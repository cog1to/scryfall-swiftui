//
//  Rarity+Colors.swift
//  Scryfall
//
//  Created by Alexander on 28.08.2021.
//

import Foundation
import ScryfallModel
import SwiftUI

extension Rarity {
    var color: SwiftUI.Color {
        switch self {
        case .common:
            return .init("RarityCommon")
        case .uncommon:
            return .init("RarityUncommon")
        case .rare:
            return .init("RarityRare")
        case .mythic:
            return .init("RarityMythic")
        case .bonus:
            return .init("RarityBonus")
        case .special:
            return .init("RaritySpecial")
        }
    }
}
