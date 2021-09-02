//
//  Optionals+Empty.swift
//  Scryfall
//
//  Created by Alexander on 02.09.2021.
//

import Foundation

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        switch self {
        case .none:
            return true
        case let .some(value):
            return value.isEmpty
        }
    }
}
