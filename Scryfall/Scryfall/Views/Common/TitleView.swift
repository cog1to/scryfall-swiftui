//
//  TitleView.swift
//  Scryfall
//
//  Created by Alexander on 06.07.2021.
//

import SwiftUI
import ScryfallModel

struct TitleView: View {
    let name: String
    let manaCost: String?
    let provider: SymbolProvider

    var body: some View {
        HStack {
            MagicTextView(text: fullText, bold: true, provider: provider)
                .font(Style.Fonts.title())
                .lineLimit(nil)
            Spacer()
        }
        .padding(.vertical, Style.listElementPadding)
        .padding(.horizontal, Style.listElementHorizontalPadding)
    }

    var fullText: String {
        if let manaCost = manaCost, !manaCost.isEmpty {
            return "\(name) \(manaCost)"
        } else {
            return name
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(
            name: "Akoum Battleslinger",
            manaCost: "{2}{R}{R}",
            provider: DefaultSymbolProvider(
                fileCache: ImageCache(),
                viewModel: CommonViewModel(client: StubClient())
            )
        )
    }
}
