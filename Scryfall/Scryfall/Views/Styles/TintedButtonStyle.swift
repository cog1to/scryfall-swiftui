//
//  TintedButtonStyle.swift
//  Scryfall
//
//  Created by Alexander on 17.08.2021.
//

import Foundation
import SwiftUI

struct TintedStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color("AccentTint") : Color("Accent"))
            .cornerRadius(2.0)
  }
}

