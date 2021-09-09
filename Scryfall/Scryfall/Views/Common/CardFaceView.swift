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
    let flavorName: String?
    let manaCost: String?
    let typeLine: String?
    let colorIndicator: [ScryfallModel.Color]?
    let oracleText: String?
    let flavorText: String?
    let power: String?
    let toughness: String?
    let loyalty: String?
    let language: Language
    let provider: SymbolProvider

    var body: some View {
        VStack(spacing: 0) {
            Divider()

            TitleView(
                name: name,
                flavorName: flavorName,
                manaCost: manaCost,
                language: language,
                provider: provider
            )

            if let type = typeLine {
                Divider()
                HStack(spacing: 0) {
                    if let indicator = colorIndicator {
                        ColorIndicatorView(colors: indicator)
                            .frame(width: 15, height: 15)
                            .padding(.leading, Style.listElementHorizontalPadding)
                    }
                    ParagraphView(text: type, language: language, provider: provider)
                }
            }

            if let oracleText = oracleText, !oracleText.isEmpty {
                Divider()
                ParagraphView(
                    text: formattedString(for: oracleText, language: language),
                    language: language,
                    provider: provider
                )
            }

            if let flavorText = flavorText {
                ItalicTextView(
                    text: formattedString(for: flavorText, language: language),
                    language: language
                )
            }

            if let loyalty = loyalty {
                Divider()
                TitleView(
                    name: "Loyalty: \(loyalty)",
                    flavorName: nil,
                    manaCost: nil,
                    language: .english,
                    provider: provider
                )
            }

            if power != nil || toughness != nil {
                Divider()
                ParagraphView(
                    text: "\(power ?? "")/\(toughness ?? "")",
                    language: .english,
                    provider: provider
                )
            }
        }
    }

    // MARK: - Formatting

    private func formattedString(for string: String, language: Language) -> String {
        if language == .phyrexian {
            return string.replacingOccurrences(of: "|", with: "|\u{200D}")
        } else {
            return string
        }
    }
}
