//
//  Rarity.swift
//  
//
//  Created by Alexander on 14.08.2021.
//

import Foundation

public enum Rarity: String, Codable {
    case common = "common"
    case uncommon = "uncommon"
    case rare = "rare"
    case mythic = "mythic"
    case special = "special"
    case bonus = "bonus"

    public var title: String {
        switch self {
        case .common, .uncommon, .rare, .special, .bonus:
            return self.rawValue.uppercased()
        case .mythic:
            return "Mythic Rare"
        }
    }
}
