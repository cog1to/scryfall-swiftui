//
//  CardFaceView.swift
//  Scryfall
//
//  Created by Alexander on 06.07.2021.
//

import Foundation
import SwiftUI
import ScryfallModel

struct CardFaceView: View {
    let name: String
    let manaCost: String?
    let typeLine: String?
    let colorIndicator: [ScryfallModel.Color]?
    let oracleText: String?
    let flavorText: String?
    let power: String?
    let toughness: String?
    let loyalty: String?
    let provider: SymbolProvider

    var body: some View {
        VStack(spacing: 0) {
            Divider()

            TitleView(name: name, manaCost: manaCost, provider: provider)

            if let type = typeLine {
                Divider()
                HStack(spacing: 0) {
                    if let indicator = colorIndicator {
                        ColorIndicatorView(colors: indicator)
                            .frame(width: 15, height: 15)
                            .padding(.leading, Style.listElementHorizontalPadding)
                    }
                    ParagraphView(text: type, provider: provider)
                }
            }

            if let oracleText = oracleText {
                Divider()
                ParagraphView(text: oracleText, provider: provider)
            }

            if let flavorText = flavorText {
                ItalicTextView(text: flavorText)
            }

            if let loyalty = loyalty {
                Divider()
                TitleView(name: "Loyalty: \(loyalty)", manaCost: nil, provider: provider)
            }

            if power != nil || toughness != nil {
                Divider()
                ParagraphView(
                    text: "\(power ?? "")/\(toughness ?? "")",
                    provider: provider
                )
            }
        }
    }
}
