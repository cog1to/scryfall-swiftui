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
}

protocol SettingsProvider: AnyObject {
    var presentationStyle: PresentationStyle? { get set }
}
