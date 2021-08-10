//
//  Sorting.swift
//  Scryfall
//
//  Created by Alexander on 10.08.2021.
//

import Foundation

enum SortOrder: String, Identifiable {
    case name = "name"
    case releaseDate = "released"
    case setAndNumber = "set"
    case rarity = "rarity"
    case color = "color"
    case priceUsd = "usd"
    case priceTix = "tix"
    case priceEuro = "eur"
    case cmc = "cmc"
    case power = "power"
    case toughness = "toughness"
    case artist = "artist"
    case edhrecRank = "edhrec"

    var id: String {
        self.rawValue
    }

    var title: String {
        switch self {
        case .name: return "Name"
        case .releaseDate: return "Release Date"
        case .setAndNumber: return "Set/Number"
        case .rarity: return "Rarity"
        case .color: return "Color"
        case .priceUsd: return "Price: USD"
        case .priceTix: return "Price: TIX"
        case .priceEuro: return "Price: EUR"
        case .cmc: return "CMC"
        case .power: return "Power"
        case .toughness: return "Toughness"
        case .artist: return "Artist Name"
        case .edhrecRank: return "EDHREC Rank"
        }
    }

    static let all: [SortOrder] = [
        .name,
        .releaseDate,
        .setAndNumber,
        .rarity,
        .color,
        .priceUsd,
        .priceTix,
        .priceEuro,
        .cmc,
        .power,
        .toughness,
        .artist,
        .edhrecRank
    ]
}

enum SortDirection: Identifiable {
    case auto
    case ascending
    case descending

    var id: String {
        switch self {
        case .auto: return "auto"
        default: return value!
        }
    }

    var value: String? {
        switch self {
        case .auto: return nil
        case .ascending: return "asc"
        case .descending: return "desc"
        }
    }

    var title: String {
        switch self {
        case .auto: return "Auto"
        case .ascending: return "Asc"
        case .descending: return "Desc"
        }
    }

    static let all: [SortDirection] = [
        .auto,
        .ascending,
        .descending
    ]
}
