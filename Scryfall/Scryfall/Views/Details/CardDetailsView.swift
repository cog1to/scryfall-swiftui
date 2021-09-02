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

    @ObservedObject var model: CardDetailsViewModel

    // MARK: - DI

    @Environment(\.presentationMode) var presentation

    @EnvironmentObject var common: CommonViewModel

    let cache = ImageCache()

    let symbolProvider: SymbolProvider

    let setProvider: SetProvider

    init(card: Card, symbolProvider: SymbolProvider, setProvider: SetProvider) {
        self.symbolProvider = symbolProvider
        self.setProvider = setProvider
        self.model = CardDetailsViewModel(card: card, client: NetworkClient())
    }

    // MARK: - Body

    var body: some View {
        let card = model.card
        let languages = model.languages.map { $0.lang.abbreviation }
            + (model.languages.count > 1 ? ["︙"] : [])
        let selectedIndex = model.languages.firstIndex(where: { $0.lang == card.lang })

        ScrollView(.vertical) {
            VStack {
                VStack(spacing: Style.listElementPadding) {
                    SearchCardView(card: card, cache: cache)
                        .frame(maxWidth: 400)
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
                    .buttonStyle(TintedStyle())

                    TagListWrapper(
                        tags: languages,
                        selectedIndex: selectedIndex
                    ) {
                        if $0 < (languages.count - 1) {
                            model.card = model.languages[$0]
                            
                        } else {
                            // TODO: Update search.
                            presentation.wrappedValue.dismiss()
                        }
                    }

                    PrintsTable(cards: model.prints)
                }
                .padding(.vertical, Style.listElementBottomPadding)
                .padding(.horizontal, Style.listElementHorizontalPadding)

                if let rulings = model.rulings {
                    VStack {
                        DashedLine()
                        RulingsView(items: rulings)
                    }
                    .background(Color.systemBackground)
                }
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
