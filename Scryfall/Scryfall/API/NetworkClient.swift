//
//  DefaultClient.swift
//  Scryfall
//
//  Created by Alexander on 06.07.2021.
//

import Foundation
import Combine
import ScryfallModel

class NetworkClient: ScryfallClient {

    // MARK: - Private state

    private static let baseUrl = URL(string: "https://api.scryfall.com/")

    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-mm-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        return decoder
    }()

    private enum Endpoint: String {
        case cards = "cards/search"
        case symbology = "symbology"
        case abilityWords = "catalog/ability-words"
        case sets = "sets"

        static let baseUrl = URL(string: "https://api.scryfall.com/")!

        var url: URL {
            Self.baseUrl.appendingPathComponent(self.rawValue)
        }
    }

    // MARK: - ScryfallClient

    func cards(
        query: String,
        type: QueryType,
        sort: SortOrder,
        direction: SortDirection
    ) -> AnyPublisher<ObjectList<Card>, Error> {
        guard var components = URLComponents(url: Endpoint.cards.url, resolvingAgainstBaseURL: false) else {
            return AnyPublisher(Fail<ObjectList<Card>, Error>(error: ScryfallError.badUrl))
        }

        components.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "unique", value: type.rawValue),
            URLQueryItem(name: "order", value: sort.rawValue)
        ]

        if let sortDirection = direction.value {
            components.queryItems?.append(URLQueryItem(name: "dir", value: sortDirection))
        }

        guard let url = components.url else {
            return AnyPublisher(Fail<ObjectList<Card>, Error>(error: ScryfallError.badUrl))
        }

        return loadData(url: url)
    }

    func symbology() -> AnyPublisher<ObjectList<CardSymbol>, Error> {
        return loadData(url: Endpoint.symbology.url)
    }

    func abilityWords() -> AnyPublisher<Catalog<String>, Error> {
        return loadData(url: Endpoint.abilityWords.url)
    }

    func sets() -> AnyPublisher<ObjectList<CardSet>, Error> {
        return loadData(url: Endpoint.sets.url)
    }

    func loadUri<T>(URL: URL) -> AnyPublisher<T, Error> where T : Decodable {
        return loadData(url: URL)
    }

    func languages(card: Card) -> AnyPublisher<ObjectList<Card>, Error> {
        guard var components = URLComponents(url: Endpoint.cards.url, resolvingAgainstBaseURL: false) else {
            return AnyPublisher(Fail<ObjectList<Card>, Error>(error: ScryfallError.badUrl))
        }

        components.queryItems = [
            URLQueryItem(name: "q", value: "oracleId=\(card.oracleId) set:\(card.set) lang:any"),
            URLQueryItem(name: "unique", value: QueryType.allPrints.rawValue)
        ]

        guard let url = components.url else {
            return AnyPublisher(Fail<ObjectList<Card>, Error>(error: ScryfallError.badUrl))
        }

        return loadData(url: url)
    }

    func prints(card: Card) -> AnyPublisher<ObjectList<Card>, Error> {
        guard var components = URLComponents(url: Endpoint.cards.url, resolvingAgainstBaseURL: false) else {
            return AnyPublisher(Fail<ObjectList<Card>, Error>(error: ScryfallError.badUrl))
        }

        components.queryItems = [
            URLQueryItem(name: "q", value: "!\"\(card.name)\" include:extras"),
            URLQueryItem(name: "unique", value: QueryType.allPrints.rawValue),
            URLQueryItem(name: "order", value: SortOrder.releaseDate.rawValue)
        ]

        guard let url = components.url else {
            return AnyPublisher(Fail<ObjectList<Card>, Error>(error: ScryfallError.badUrl))
        }

        return loadData(url: url)
    }

    public func card(forUri uri: URL) -> AnyPublisher<Card, Error> {
        loadData(url: uri)
    }

    public func variations(card: Card) -> AnyPublisher<ObjectList<Card>, Error> {
        guard var components = URLComponents(url: Endpoint.cards.url, resolvingAgainstBaseURL: false) else {
            return AnyPublisher(Fail<ObjectList<Card>, Error>(error: ScryfallError.badUrl))
        }

        components.queryItems = [
            URLQueryItem(name: "q", value: "!\"\(card.name)\" is:variation"),
            URLQueryItem(name: "order", value: SortOrder.releaseDate.rawValue)
        ]

        guard let url = components.url else {
            return AnyPublisher(Fail<ObjectList<Card>, Error>(error: ScryfallError.badUrl))
        }

        return loadData(url: url)
    }

    // MARK: - Private

    private func loadData<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .mapError { urlError in
                ScryfallError.networkError(urlError)
            }
            .tryMap { response in
                try Self.decoder.decode(T.self, from: response.data)
            }
            .eraseToAnyPublisher()
    }
}
