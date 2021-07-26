//
//  SymbolContainer.swift
//  Scryfall
//
//  Created by Alexander on 22.07.2021.
//

import Foundation
import SwiftUI
import Combine

struct SymbolContainer: View {
    @ObservedObject var symbol: AsyncSymbol

    init(provider: SymbolProvider, symbol: String) {
        self.symbol = AsyncSymbol(provider: provider, symbol: symbol)
    }

    var body: Text {
        if let image = symbol.image {
            return Text(Image(uiImage: image))
        } else {
            return Text(symbol.text)
        }
    }
}
