//
//  Color+UIColor.swift
//  Scryfall
//
//  Created by Alexander on 06.07.2021.
//

import Foundation
import SwiftUI
import ScryfallModel

extension ScryfallModel.Color {
    var uiColor: SwiftUI.Color {
        switch self {
        case .red:
            return Color("MagicRed")
        case .white:
            return Color("MagicWhite")
        case .blue:
            return Color("MagicBlue")
        case .black:
            return Color("MagicBlack")
        case .green:
            return Color("MagicGreen")
        }
    }
}
