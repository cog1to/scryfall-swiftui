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

    // MARK: - Observables

    @Published private(set) var cards: [Card] = []

    @Published private(set) var error: Error?

    @Published private(set) var hasMore: Bool = false

    @Published private(set) var isEmpty: Bool = false

    let onNext = PassthroughSubject<Void, Never>()

    // MARK: - Init

    init(client: ScryfallClient, settingsProvider: SettingsProvider) {
        self.settingsProvider = settingsProvider
        self.client = client
        configure()
    }

    // MARK: - Public interface

    func loadPrints(for card: Card) {
        searchText = "!\"\(card.name)\" include:extras"
        queryType = .allPrints
        sortOrder = .releaseDate
    }

    func loadLanguages(for card: Card) {
        searchText = "oracleId=\(card.oracleId) set:\(card.set) lang:any"
        queryType = .allPrints
    }

    func loadSet(_ set: String) {
        searchText = "set:\(set)"
        queryType = .cards
        sortOrder = .setAndNumber
    }

    func loadArtist(_ artist: String) {
        searchText = "artist:\"\(artist)\""
        queryType = .cards
    }

    // MARK: - Private

    func configure() {
        // Search text.
        $searchText
            .filter { !$0.isEmpty }
            .combineLatest($queryType, $sortOrder, $sortDirection)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
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
                            guard self?.searchText == string else {
                                return
                            }

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
                        guard self?.searchText == string else {
                            return
                        }

                        self?.cards = cards
                        self?.isEmpty = cards.isEmpty
                    })
            })
            .store(in: &subscriptions)

        $searchText
            .filter { $0.isEmpty }
            .sink(receiveValue: { [weak self] _ in
                self?.lastRequest?.cancel()
                self?.cards = []
                self?.hasMore = false
                self?.isEmpty = false
                self?.nextPageUri.send(nil)
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
                            guard !(self?.searchText.isEmpty ?? true) else { return }

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
                        guard self?.searchText != nil else { return }
                        guard let self = self, !self.searchText.isEmpty else { return }
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
