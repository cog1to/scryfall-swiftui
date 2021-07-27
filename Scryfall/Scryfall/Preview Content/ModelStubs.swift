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

    static let avacynSearch: List<Card> = {
        let dataUrl = Bundle.main.url(forResource: "search_avacyn", withExtension: "json")!
        let data = try! Data(contentsOf: dataUrl)
        return try! ModelStubs.decoder.decode(List<Card>.self, from: data)
    }()

    static let gleemaxSearch: List<Card> = {
        let dataUrl = Bundle.main.url(forResource: "gleemax", withExtension: "json")!
        let data = try! Data(contentsOf: dataUrl)
        return try! ModelStubs.decoder.decode(List<Card>.self, from: data)
    }()

    static let garrukSearch: List<Card> = {
        let dataUrl = Bundle.main.url(forResource: "search_garruk", withExtension: "json")!
        let data = try! Data(contentsOf: dataUrl)
        return try! ModelStubs.decoder.decode(List<Card>.self, from: data)
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
