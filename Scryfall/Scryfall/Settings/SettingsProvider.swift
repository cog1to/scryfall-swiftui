//
//  SettingsProvider.swift
//  Scryfall
//
//  Created by Alexander on 04.08.2021.
//

import Foundation

enum PresentationStyle: String, Codable, Identifiable {
    case text
    case card

    var id: String {
        return title
    }

    var title: String {
        switch self {
        case .text:
            return "Text"
        case .card:
            return "Cards"
        }
    }

    static let all: [PresentationStyle] = [
        .text,
        .card
    ]
}

enum QueryType: String, Codable, Identifiable {
    case cards = "cards"
    case allPrints = "prints"
    case uniqueArt = "art"

    var id: String {
        return title
    }

    var title: String {
        switch self {
        case .cards:
            return "Cards"
        case .allPrints:
            return "All Prints"
        case .uniqueArt:
            return "Unique Art"
        }
    }

    static let all: [QueryType] = [
        .cards,
        .allPrints,
        .uniqueArt
    ]
}

protocol SettingsProvider: AnyObject {
    var presentationStyle: PresentationStyle? { get set }
    var queryType: QueryType? { get set }
}
