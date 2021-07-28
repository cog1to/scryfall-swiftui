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

    // MARK: - Public

    @Input var searchText = ""

    @Published private(set) var cards: Result<[Card], Error> = .success([])

    init(client: ScryfallClient) {
        self.client = client
        configure()
    }

    // MARK: - Private

    func configure() {
        $searchText
            .filter { !$0.isEmpty }
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .flatMap { query in
                self.client.cards(query: query)
                    .map { list in
                        Result<[Card], Error>.success(list.data)
                    }
                    .catch { error in
                        Just<Result<[Card], Error>>(.failure(error))
                    }
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$cards)
    }
}
