//
//  Legality+Color.swift
//  Scryfall
//
//  Created by Alexander on 14.08.2021.
//

import Foundation
import ScryfallModel
import SwiftUI

extension LegalityList.Legality {
    var color: SwiftUI.Color {
        switch self {
        case .legal: return .init("PlaqueGreen")
        case .notLegal: return .init("PlaqueGray")
        case .banned: return .init("PlaqueRed")
        case .restricted: return .init("PlaqueBlue")
        }
    }

    var title: String {
        switch self {
        case .legal: return "LEGAL"
        case .notLegal: return "NOT LEGAL"
        case .banned: return "BANNED"
        case .restricted: return "RESTRICT."
        }
    }
}
