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

    let symbolProvider: SymbolProvider

    let setProvider: SetProvider

    init(card: Card, symbolProvider: SymbolProvider, setProvider: SetProvider) {
        self.card = card
        self.symbolProvider = symbolProvider
        self.setProvider = setProvider

        UINavigationBar.appearance().backgroundColor = UIColor(named: "Background")
    }

    // MARK: - Body

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: Style.listElementPadding) {
                SearchCardView(card: card, cache: cache)
                CardDescriptionView(card: card, provider: symbolProvider)

                Button(action: {
                    // TODO: Hook back to search.
                }) {
                    SetDetailsView(
                        setName: card.setName,
                        setCode: card.set,
                        cardNumber: card.number,
                        rarity: card.rarity,
                        language: card.lang,
                        provider: setProvider
                    )
                }
            }
            .padding(.vertical, Style.listElementBottomPadding)
            .padding(.horizontal, Style.listElementHorizontalPadding)
        }
        .background(Color("Background"))
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct CardDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailsView(
            card: ModelStubs.akoumBattlesinger,
            symbolProvider: DefaultSymbolProvider(
                fileCache: ImageCache(),
                viewModel: CommonViewModel(client: StubClient())
            ),
            setProvider: DefaultSetProvider(
                fileCache: ImageCache(),
                viewModel: CommonViewModel(client: StubClient())
            )
        )
    }
}
