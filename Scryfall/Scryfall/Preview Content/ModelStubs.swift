//
//  ModelStubs.swift
//  Scryfall
//
//  Created by Alexander on 06.07.2021.
//

import Foundation
import ScryfallModel

final class ModelStubs {
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-mm-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        return decoder
    }()

    // MARK: - Lists

    static func cards(_ filename: String) -> ObjectList<Card> {
        let dataUrl = Bundle.main.url(forResource: filename, withExtension: "json")!
        let data = try! Data(contentsOf: dataUrl)
        return try! ModelStubs.decoder.decode(ObjectList<Card>.self, from: data)
    }

    static let avacynSearch: ObjectList<Card> = {
        cards("search_avacyn")
    }()

    static let gleemaxSearch: ObjectList<Card> = {
        cards("gleemax")
    }()

    static let garrukSearch: ObjectList<Card> = {
        cards("search_garruk")
    }()

    static let akoumSearch: ObjectList<Card> = {
        cards("search_akoum")
    }()

    static let exaltedSearch: ObjectList<Card> = {
        cards("search_exalted")
    }()

    // MARK: - Cards

    static let akoum: Card = {
        let dataUrl = Bundle.main.url(forResource: "akoum", withExtension: "json")!
        let data = try! Data(contentsOf: dataUrl)
        return try! ModelStubs.decoder.decode(Card.self, from: data)
    }()

    static let akoumBattlesinger: Card = {
        let dataUrl = Bundle.main.url(forResource: "akoum_battlesinger", withExtension: "json")!
        let data = try! Data(contentsOf: dataUrl)
        return try! ModelStubs.decoder.decode(Card.self, from: data)
    }()

    static let avacyn: Card = {
        let dataUrl = Bundle.main.url(forResource: "avacyn", withExtension: "json")!
        let data = try! Data(contentsOf: dataUrl)
        return try! ModelStubs.decoder.decode(Card.self, from: data)
    }()

    static let abominationOfGudul: Card = {
        let dataUrl = Bundle.main.url(forResource: "abomination_of_gudul", withExtension: "json")!
        let data = try! Data(contentsOf: dataUrl)
        return try! ModelStubs.decoder.decode(Card.self, from: data)
    }()
}
