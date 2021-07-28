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
}

protocol ScryfallClient {
    func cards(query: String) -> AnyPublisher<ObjectList<Card>, Error>
    func symbology() -> AnyPublisher<ObjectList<CardSymbol>, Error>
    func abilityWords() -> AnyPublisher<Catalog<String>, Error>
}
