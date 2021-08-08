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
    func cards(query: String, type: QueryType) -> AnyPublisher<ObjectList<Card>, Error>
    func symbology() -> AnyPublisher<ObjectList<CardSymbol>, Error>
    func abilityWords() -> AnyPublisher<Catalog<String>, Error>
    func loadUri<T: Decodable>(URL: URL) -> AnyPublisher<T, Error>
}
