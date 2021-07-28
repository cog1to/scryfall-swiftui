//
//  DefaultClient.swift
//  Scryfall
//
//  Created by Alexander on 06.07.2021.
//

import Foundation
import Combine
import ScryfallModel

class DefaultClient: ScryfallClient {

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

        static let baseUrl = URL(string: "https://api.scryfall.com/")!

        var url: URL {
            Self.baseUrl.appendingPathComponent(self.rawValue)
        }
    }

    // MARK: - ScryfallClient

    func cards(query: String) -> AnyPublisher<ObjectList<Card>, Error> {
        guard var components = URLComponents(url: Endpoint.cards.url, resolvingAgainstBaseURL: false) else {
            return AnyPublisher(Fail<ObjectList<Card>, Error>(error: ScryfallError.badUrl))
        }

        components.queryItems = [URLQueryItem(name: "q", value: query)]
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
