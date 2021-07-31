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

    private var nextPageUri = CurrentValueSubject<URL?, Never>(nil)

    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Public

    @Input var searchText = ""

    @Published private(set) var cards: [Card] = []

    @Published private(set) var error: Error?

    @Published private(set) var hasMore: Bool = false

    let onNext = PassthroughSubject<Void, Never>()

    init(client: ScryfallClient) {
        self.client = client
        configure()
    }

    // MARK: - Private

    func configure() {
        // Search text.
        $searchText
            .filter { !$0.isEmpty }
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink(receiveValue: { string in
                self.client.cards(query: string)
                    .receive(on: DispatchQueue.main)
                    .print()
                    .handleEvents(
                        receiveOutput: { output in
                            if let nextPage = output.nextPage {
                                self.nextPageUri.send(nextPage)
                                self.hasMore = true
                            } else {
                                self.hasMore = false
                            }
                        },
                        receiveCompletion: { result in
                            if case let .failure(error) = result {
                                self.error = error
                            }
                        }
                    )
                    .replaceError(with: .empty())
                    .map { data in data.data }
                    .assign(to: &self.$cards)
            })
            .store(in: &subscriptions)

        // Next page loading.
        onNext.compactMap { _ in self.nextPageUri.value }
            .flatMap { url -> AnyPublisher<ObjectList<Card>, Error> in
                self.client.loadUri(URL: url)
            }
            .receive(on: DispatchQueue.main)
            .handleEvents(
                receiveOutput: { output in
                    if let nextPage = output.nextPage {
                        self.nextPageUri.send(nextPage)
                        self.hasMore = true
                    } else {
                        self.hasMore = false
                    }
                }, receiveCompletion: { result in
                    if case let .failure(error) = result {
                        self.error = error
                    }
                }
            )
            .replaceError(with: .empty())
            .map { data in self.cards + data.data }
            .assign(to: &$cards)
    }
}
