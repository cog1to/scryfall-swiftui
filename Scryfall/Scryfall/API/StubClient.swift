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

    private func load<T: Decodable>(filename: String) -> AnyPublisher<T, Error> {
        let dataUrl = Bundle.main.url(forResource: filename, withExtension: "json")!
        guard let data = try? Data(contentsOf: dataUrl) else {
            return Fail<T, Error>(error: ScryfallError.parsingError)
                .eraseToAnyPublisher()
        }

        guard let list = try? Self.decoder.decode(T.self, from: data) else {
            return Fail<T, Error>(error: ScryfallError.parsingError)
                .eraseToAnyPublisher()
        }

        return Just(list)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func cards(
        query: String, type: QueryType, sort: SortOrder, direction: SortDirection
    ) -> AnyPublisher<ObjectList<Card>, Error> {
        return load(filename: "card_search_sample")
    }

    func loadUri<T: Decodable>(URL: URL) -> AnyPublisher<T, Error> {
        return load(filename: "card_search_sample")
    }

    func symbology() -> AnyPublisher<ObjectList<CardSymbol>, Error> {
        load(filename: "symbology")
    }

    func sets() -> AnyPublisher<ObjectList<CardSet>, Error> {
        load(filename: "sets")
    }

    func abilityWords() -> AnyPublisher<Catalog<String>, Error> {
        load(filename: "ability_words")
    }

    func languages(card: Card) -> AnyPublisher<ObjectList<Card>, Error> {
        load(filename: "avacyn_prints")
    }

    func prints(card: Card) -> AnyPublisher<ObjectList<Card>, Error> {
        load(filename: "avacyn_prints")
    }
}
