//
//  CardDetailsViewModel.swift
//  Scryfall
//
//  Created by Alexander on 22.08.2021.
//

import Foundation
import Combine
import ScryfallModel

class CardDetailsViewModel: ObservableObject {

    // MARK: - Private

    var subsciptions = Set<AnyCancellable>()

    // MARK: - Models

    @Published var prints: [Card] = []

    @Published var card: Card

    // MARK: - Private

    private let client: ScryfallClient

    // MARK: - Init

    init(card: Card, client: ScryfallClient) {
        self.card = card
        self.client = client

        client.prints(card: card)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .replaceError(with: .empty())
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .sink { self.prints = $0 }
            .store(in: &subsciptions)
    }
}
