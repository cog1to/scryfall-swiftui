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

    init(
        card: Card,
        symbolProvider: SymbolProvider,
        setProvider: SetProvider,
        onAllPrintsSelected: ((Card) -> ())? = nil,
        onAllLanguagesSelected: ((Card) -> ())? = nil,
        onSetSelected: ((String) -> ())? = nil,
        onArtistSelected: ((String) -> ())? = nil
    ) {
        self.symbolProvider = symbolProvider
        self.setProvider = setProvider
        self.model = CardDetailsViewModel(card: card, client: NetworkClient())
        self.onAllPrintsSelected = onAllPrintsSelected
        self.onAllLanguagesSelected = onAllLanguagesSelected
        self.onSetSelected = onSetSelected
        self.onArtistSelected = onArtistSelected
    }

    // MARK: - Callbacks

    let onAllPrintsSelected: ((Card) -> ())?

    let onAllLanguagesSelected: ((Card) -> ())?

    let onSetSelected: ((String) -> ())?

    let onArtistSelected: ((String) -> ())?

    // MARK: - State

    @State var flipped = false

    @State var cardRotationAngle = 0.0

    // MARK: - Body

    var body: some View {
        let card = model.card
        let languages = model.languages.map { $0.lang.abbreviation }
            + (model.languages.count > 1 ? ["︙"] : [])
        let selectedIndex = model.languages.firstIndex(where: { $0.lang == card.lang })

        ScrollView(.vertical) {
            VStack {
                VStack(spacing: Style.listElementPadding) {
                    SearchCardView(
                        card: card,
                        cache: cache,
                        face: card.cardFaces.isNilOrEmpty
                            ? nil
                            : (flipped ? 1 : 0)
                    )
                    .frame(maxWidth: 400)
                    .shadow(radius: 4)
                    .rotation3DEffect(
                        .degrees(cardRotationAngle),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )

                    if (card.cardFaces?.count ?? 0) > 1 {
                        Button(action: {
                            withAnimation(Animation.linear(duration: Self.animationDuration)) {
                                self.cardRotationAngle += 180
                            }

                            DispatchQueue.main.asyncAfter(deadline: .now() + Self.animationDuration/2.0) {
                                self.flipped = !self.flipped
                            }
                        }) {
                            HStack {
                                Image("Transform")
                                    .resizable()
                                    .frame(width: 14, height: 14)
                                Text("Transform")
                            }
                            .padding(8)
                            .background(.systemBackground)
                            .border(
                                Color("Link"),
                                width: 1,
                                cornerRadius: 4,
                                style: .circular
                            )
                        }
                        .foregroundColor(Color("Link"))
                    }

                    CardDescriptionView(
                        card: card,
                        provider: symbolProvider,
                        onArtistSelected: { artist in
                            if let callback = onArtistSelected {
                                callback(artist)
                                presentation.wrappedValue.dismiss()
                            }
                        }
                    )

                    Button(action: {
                        if let callback = onSetSelected {
                            callback(model.card.set)
                            presentation.wrappedValue.dismiss()
                        }
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
                            if let callback = onAllLanguagesSelected {
                                callback(model.card)
                                presentation.wrappedValue.dismiss()
                            }
                        }
                    }

                    if let relatedCards = model.relatedCards, !relatedCards.isEmpty {
                        RelatedItemsTable(
                            cards: relatedCards,
                            currentCard: model.card
                        ) { card in
                            model.card = card
                        }
                    }

                    PrintsTable(
                        cards: model.prints,
                        currentCard: model.card,
                        onCardSelected:  { card in
                            model.card = card
                        },
                        onAllPrintsSelected: {
                            if let callback = onAllPrintsSelected {
                                callback(model.card)
                                presentation.wrappedValue.dismiss()
                            }
                        }
                    )
                }
                .padding(.vertical, Style.listElementBottomPadding)
                .padding(.horizontal, Style.listElementHorizontalPadding)

                if let rulings = model.rulings, !rulings.isEmpty {
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

    // MARK: - Config

    static let animationDuration: Double = 0.4
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
