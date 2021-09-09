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
    let flavorName: String?
    let manaCost: String?
    let language: Language
    let provider: SymbolProvider

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            MagicTextView(
                text: fullText,
                bold: true,
                language: language,
                provider: provider
            )
            .font(Style.Fonts.title)
            .frame(maxWidth: .infinity, alignment: .leading)

            if let flavorName = flavorName {
                Text(flavorName)
                    .font(Style.Fonts.subtitle.italic())
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .lineLimit(nil)
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
            flavorName: nil,
            manaCost: "{2}{R}{R}",
            language: .english,
            provider: DefaultSymbolProvider(
                fileCache: ImageCache(),
                viewModel: CommonViewModel(client: StubClient())
            )
        )
    }
}
