//
//  SearchResultsViewModel.swift
//  Scryfall
//
//  Created by Alexander on 28.07.2021.
//

import Foundation
import Combine
import ScryfallModel

class SearchResultsViewModel: ObservableObject {

    // MARK: - Private state

    private let client: ScryfallClient

    private let settingsProvider: SettingsProvider

    private var nextPageUri = CurrentValueSubject<URL?, Never>(nil)

    private var subscriptions = Set<AnyCancellable>()

    private var lastRequest: AnyCancellable?

    // MARK: - Public

    @Input var searchText = ""

    @Input var queryType = QueryType.cards

    @Input var sortOrder = SortOrder.name

    @Input var sortDirection = SortDirection.auto

    @Published private(set) var cards: [Card] = []

    @Published private(set) var error: Error?

    @Published private(set) var hasMore: Bool = false

    let onNext = PassthroughSubject<Void, Never>()

    init(client: ScryfallClient, settingsProvider: SettingsProvider) {
        self.settingsProvider = settingsProvider
        self.client = client
        configure()
    }

    // MARK: - Private

    func configure() {
        // Search text.
        $searchText
            .filter { !$0.isEmpty }
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .combineLatest($queryType, $sortOrder, $sortDirection)
            .sink(receiveValue: { [weak self] string, type, order, dir in
                guard let self = self else { return }

                if let lastRequest = self.lastRequest {
                    lastRequest.cancel()
                }

                self.lastRequest = self.client.cards(
                    query: string,
                    type: type,
                    sort: order,
                    direction: dir
                )
                    .receive(on: DispatchQueue.main)
                    .handleEvents(
                        receiveOutput: { [weak self] output in
                            if let nextPage = output.nextPage {
                                self?.nextPageUri.send(nextPage)
                                self?.hasMore = true
                            } else {
                                self?.hasMore = false
                            }
                        },
                        receiveCompletion: { [weak self] result in
                            if case let .failure(error) = result {
                                self?.error = error
                            }
                        }
                    )
                    .replaceError(with: .empty())
                    .map { data in data.data }
                    .sink(receiveValue: { [weak self] cards in
                        self?.cards = cards
                    })
            })
            .store(in: &subscriptions)

        // Next page loading.
        onNext.compactMap { _ in self.nextPageUri.value }
            .sink(receiveValue: { [weak self] url in
                guard let self = self else { return }

                if let lastRequest = self.lastRequest {
                    lastRequest.cancel()
                }

                self.lastRequest = self.client.loadUri(URL: url)
                    .receive(on: DispatchQueue.main)
                    .handleEvents(
                        receiveOutput: { [weak self] (output: ObjectList<Card>) in
                            if let nextPage = output.nextPage {
                                self?.nextPageUri.send(nextPage)
                                self?.hasMore = true
                            } else {
                                self?.hasMore = false
                            }
                        }, receiveCompletion: { [weak self] result in
                            if case let .failure(error) = result {
                                self?.error = error
                            }
                        }
                    )
                    .replaceError(with: .empty())
                    .sink { [weak self] data in
                        guard let self = self else { return }
                        self.cards = self.cards + data.data
                    }
            })
            .store(in: &subscriptions)

        // Query type changed.
        $queryType
            .handleEvents(receiveOutput: { self.settingsProvider.queryType = $0 })
            .sink(receiveValue: { _ in return })
            .store(in: &subscriptions)
    }
}
