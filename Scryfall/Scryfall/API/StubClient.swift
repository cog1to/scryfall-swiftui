//
//  StubClient.swift
//  Scryfall
//
//  Created by Alexander on 06.07.2021.
//

import Foundation
import Combine
import ScryfallModel

final class StubClient: ScryfallClient {

    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-mm-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        return decoder
    }()

    func cards(query: String) -> AnyPublisher<List<Card>, Error> {
        let dataUrl = Bundle.main.url(forResource: "card_search_sample", withExtension: "json")!
        guard let data = try? Data(contentsOf: dataUrl) else {
            return Fail<List<Card>, Error>(error: ScryfallError.parsingError)
                .eraseToAnyPublisher()
        }

        guard let list = try? Self.decoder.decode(List<Card>.self, from: data) else {
            return Fail<List<Card>, Error>(error: ScryfallError.parsingError)
                .eraseToAnyPublisher()
        }

        return Just(list)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func symbology() -> AnyPublisher<List<CardSymbol>, Error> {
        let dataUrl = Bundle.main.url(forResource: "symbology", withExtension: "json")!
        guard let data = try? Data(contentsOf: dataUrl) else {
            return Fail<List<CardSymbol>, Error>(error: ScryfallError.parsingError)
                .eraseToAnyPublisher()
        }

        guard let list = try? Self.decoder.decode(List<CardSymbol>.self, from: data) else {
            return Fail<List<CardSymbol>, Error>(error: ScryfallError.parsingError)
                .eraseToAnyPublisher()
        }

        return Just(list)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
