//
//  ItalicTextView.swift
//  Scryfall
//
//  Created by Alexander on 22.08.2021.
//

import Foundation
import UIKit
import SwiftUI
import ScryfallModel

struct ItalicTextView: View {

    let text: String
    let language: Language

    var body: some View {
        HStack {
            Text(text)
                .lineBreakMode(language == .phyrexian ? .byCharWrapping : .byWordWrapping)
                .font(font)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
        .padding(.top, Style.listElementPadding)
        .padding(.horizontal, Style.listElementHorizontalPadding)
        .padding(.bottom, Style.listElementPadding)
    }

    var font: Font {
        switch language {
        case .english, .french, .german, .italian, .spanish, .latin, .portuguese:
            return Style.Fonts.flavor
        case .russian:
            return Style.Fonts.flavorCyrillic
        case .phyrexian:
            return Style.Fonts.phyrexian
        default:
            return Font.body
        }
    }
}
