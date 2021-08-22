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
    func cards(
        query: String, type: QueryType, sort: SortOrder, direction: SortDirection
    ) -> AnyPublisher<ObjectList<Card>, Error>
    func symbology() -> AnyPublisher<ObjectList<CardSymbol>, Error>
    func abilityWords() -> AnyPublisher<Catalog<String>, Error>
    func sets() -> AnyPublisher<ObjectList<CardSet>, Error>
    func loadUri<T: Decodable>(URL: URL) -> AnyPublisher<T, Error>
    func prints(card: Card) -> AnyPublisher<ObjectList<Card>, Error>
}
