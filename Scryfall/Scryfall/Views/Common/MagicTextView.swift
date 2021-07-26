//
//  MagicTextView.swift
//  Scryfall
//
//  Created by Alexander on 25.07.2021.
//

import Foundation
import SwiftUI
import UIKit

struct MagicTextView: View {

    let text: [TextToken]

    let bold: Bool

    @ObservedObject var symbols: AsyncSymbolSet

    init(text: String, bold: Bool, provider: SymbolProvider) {
        self.text = text.tokenize()
        self.bold = bold
        self.symbols = AsyncSymbolSet(
            provider: provider,
            symbols: self.text.compactMap {
                if case let .symbol(value) = $0 { return value }
                return nil
            }
        )
    }

    var body: some View {
        text.reduce(Text(""), { acc, elem in
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
        .fixedSize(horizontal: false, vertical: true)
    }
}
