//
//  CardDetailsView.swift
//  Scryfall
//
//  Created by Alexander on 11.08.2021.
//

import SwiftUI
import ScryfallModel

struct CardDetailsView: View {

    // MARK: - Model

    let card: Card

    // MARK: - DI

    @EnvironmentObject var common: CommonViewModel

    let cache = ImageCache()

    let provider: SymbolProvider

    init(card: Card, provider: SymbolProvider) {
        self.card = card
        self.provider = provider

        UINavigationBar.appearance().backgroundColor = UIColor(named: "Background")
    }

    // MARK: - Body

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                SearchCardView(card: card, cache: cache)
                    .padding(.horizontal, Style.listElementHorizontalPadding)
                    .padding(.vertical, Style.listElementPadding)
                CardDescriptionView(card: card, provider: provider)
                    .padding(.horizontal, Style.listElementHorizontalPadding)
                    .padding(.vertical, Style.listElementPadding)
            }
        }
        .background(Color("Background"))
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct CardDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailsView(
            card: ModelStubs.akoumBattlesinger,
            provider: DefaultSymbolProvider(
                fileCache: ImageCache(),
                viewModel: CommonViewModel(client: StubClient())
            )
        )
    }
}
