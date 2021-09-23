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

    @Published var languages: [Card] = []

    @Published var prints: [Card] = []

    @Published var relatedCards: [Card] = []

    @Published var card: Card {
        didSet {
            loadAll()
        }
    }

    @Published var rulings: [Ruling] = []

    @Published var variationSource: Card?

    @Published var variations: [Card] = []

    // MARK: - Private

    private let client: ScryfallClient

    // MARK: - Init

    init(card: Card, client: ScryfallClient) {
        self.card = card
        self.client = client

        loadAll()
    }

    // MARK: - Data loaders

    private func loadAll() {
        loadLanguages()
        loadPrints()
        loadRulings()
        loadRelatedCards()
        loadVariationSource()
        loadVariations()
    }

    private func loadLanguages() {
        client.languages(card: card)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .replaceError(with: .empty())
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            // Workaround for non-existent "all languages prints" endpoints.
            .map { $0.unique(keyPath: \.lang) }
            .sink { self.languages = $0 }
            .store(in: &subsciptions)
    }

    private func loadPrints() {
        client.loadUri(URL: card.printsSearchUri)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .replaceError(with: ObjectList<Card>.empty())
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .sink { self.prints = $0 }
            .store(in: &subsciptions)
    }

    private func loadRulings() {
        client.loadUri(URL: card.rulingsUri)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .replaceError(with: ObjectList<Ruling>.empty())
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .sink { self.rulings = $0 }
            .store(in: &subsciptions)
    }

    private func loadRelatedCards() {
        if let parts = card.allParts {
            parts.publisher
                .subscribe(on: DispatchQueue.global(qos: .default))
                .flatMap { part -> AnyPublisher<Card?, Never> in
                    self.client.card(forUri: part.uri)
                        .map { card -> Card? in card }
                        .replaceError(with: nil)
                        .eraseToAnyPublisher()
                }
                .compactMap { result in
                    result
                }
                .collect()
                .receive(on: DispatchQueue.main)
                .sink { self.relatedCards = $0 }
                .store(in: &subsciptions)
        }
    }

    private func loadVariationSource() {
        if card.variation, let cardId = card.variationOfId {
            client.card(id: cardId)
                .subscribe(on: DispatchQueue.global(qos: .default))
                .map { card -> Card? in card }
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main)
                .sink { self.variationSource = $0 }
                .store(in: &subsciptions)
        } else {
            variationSource = nil
        }
    }

    private func loadVariations() {
        client.variations(card: card)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .replaceError(with: ObjectList<Card>.empty())
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .sink { self.variations = $0 }
            .store(in: &subsciptions)
    }
}
