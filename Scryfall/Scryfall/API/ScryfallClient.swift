//
//  ScryfallClient.swift
//  Scryfall
//
//  Created by Alexander on 06.07.2021.
//

import Foundation
import Combine
import ScryfallModel

enum ScryfallError: Error {
    case parsingError
    case badUrl
    case networkError(Error)
}

protocol ScryfallClient {
    /// Loads a given URI
    func loadUri<T: Decodable>(URL: URL) -> AnyPublisher<T, Error>

    /// Gets a list of cards for given query
    func cards(
        query: String,
        type: QueryType,
        sort: SortOrder,
        direction: SortDirection
    ) -> AnyPublisher<ObjectList<Card>, Error>

    /// Gets a list of symbols that can occur in card text
    func symbology() -> AnyPublisher<ObjectList<CardSymbol>, Error>

    /// Gets a list of known ability words
    func abilityWords() -> AnyPublisher<Catalog<String>, Error>

    /// Gets a list of known card sets
    func sets() -> AnyPublisher<ObjectList<CardSet>, Error>

    /// Gets a list of cards in all printed languages for a given card
    func languages(card: Card) -> AnyPublisher<ObjectList<Card>, Error>

    /// Gets a list of unique prints for a given cards
    func prints(card: Card) -> AnyPublisher<ObjectList<Card>, Error>

    /// Loads a single card from a direct card URI
    func card(forUri: URL) -> AnyPublisher<Card, Error>
}
