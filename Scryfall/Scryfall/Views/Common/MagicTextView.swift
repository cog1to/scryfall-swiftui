//
//  MagicTextView.swift
//  Scryfall
//
//  Created by Alexander on 25.07.2021.
//

import Foundation
import SwiftUI
import UIKit
import ScryfallModel

struct MagicTextView: View {

    let text: TokenizedText
    let bold: Bool
    let language: Language

    @ObservedObject var symbols: AsyncSymbolSet

    @EnvironmentObject var model: CommonViewModel

    init(text: String, bold: Bool, language: Language, provider: SymbolProvider) {
        self.text = text.formatted()
        self.bold = bold
        self.language = language
        self.symbols = AsyncSymbolSet(
            provider: provider,
            symbols: self.text.symbols
        )
    }

    var body: some View {
        (rulesText + reminderText)
            .fixedSize(horizontal: false, vertical: true)
    }

    var rulesText: Text {
        let font: Font = {
            switch language {
            case .phyrexian:
                return Style.Fonts.phyrexian
            default:
                return Style.Fonts.main
            }
        }()

        return text.rules.enumerated().reduce(Text(""), { acc, elem in
            switch elem.1 {
            case .plain(let str):
                if elem.0 == 0, model.abilityWords.data.contains(where: { str.hasPrefix($0) }) {
                    let abilitySplit = str.split(separator: "—").map({ String($0) })
                    return acc
                        + Text(abilitySplit.first!).fontWeight(.regular).font(Style.Fonts.italic)
                        + Text(" — \(abilitySplit.last!)").fontWeight(.regular).font(font)
                } else {
                    return acc + Text(str).fontWeight(bold ? .medium : .regular).font(font)
                }
            case .symbol(let str):
                if let image = symbols.symbols[str] {
                    return acc + Text(Image(uiImage: image)).baselineOffset(-2)
                } else {
                    return acc + Text(str)
                }
            }
        })
    }

    var reminderText: Text {
        let font: Font = {
            switch language {
            case .russian:
                return Style.Fonts.italicCyrillic
            case .phyrexian:
                return Style.Fonts.phyrexian
            default:
                return Style.Fonts.italic
            }
        }()

        return text.reminder.isEmpty
            ? Text("")
            : text.reminder.reduce(Text(""), { acc, elem in
                switch elem {
                case .plain(let str):
                    return acc + Text(str).fontWeight(bold ? .medium : .regular)
                case .symbol(let str):
                    if let image = symbols.symbols[str] {
                        return acc + Text(Image(uiImage: image)).baselineOffset(-2)
                    } else {
                        return acc + Text(str)
                    }
                }
            })
            .font(font)
    }
}
