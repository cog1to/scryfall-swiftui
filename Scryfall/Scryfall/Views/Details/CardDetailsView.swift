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

    @ObservedObject private var model: CardDetailsViewModel

    // MARK: - DI

    @Environment(\.presentationMode) private var presentation

    @EnvironmentObject private var common: CommonViewModel

    private let cache = ImageCache()

    private let symbolProvider: SymbolProvider

    private let setProvider: SetProvider

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

    // MARK: - Model accessors

    private var card: Card {
        model.card
    }

    private var languages: [String] {
        model.languages.map { $0.lang.abbreviation }
            + (model.languages.count > 1 ? ["︙"] : [])
    }

    private var selectedIndex: Int? {
        model.languages.firstIndex(where: { $0.lang == card.lang })
    }

    // MARK: - Body

    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical) {
                VStack {
                    if proxy.size.width >= 1024 {
                        wideLayout
                            .padding(Style.listElementPadding)
                    } else {
                        shortLayout
                    }

                    if let rulings = model.rulings, !rulings.isEmpty {
                        VStack {
                            DashedLine()
                            RulingsView(items: rulings)
                        }
                        .background(Color.systemBackground)
                    } else {
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 0)
                    }
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .background(Color("Background"))
            .navigationBarTitle("", displayMode: .inline)
        }
    }

    // MARK: - Layout

    var wideLayout: some View {
        HStack(alignment: .top) {
            VStack {
                cardView
            }

            VStack {
                descriptionView
            }

            VStack {
                supplementaryView
            }
        }
    }

    var shortLayout: some View {
        VStack(spacing: Style.listElementPadding) {
            cardView
            descriptionView
            supplementaryView
        }
        .frame(maxWidth: 560)
        .padding(.vertical, Style.listElementBottomPadding)
        .padding(.horizontal, Style.listElementHorizontalPadding)
    }

    // MARK: - Subviews

    var descriptionView: some View {
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
    }

    var cardView: some View {
        Group {
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
        }
    }

    var supplementaryView: some View {
        Group {
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

            if let variationSource = model.variationSource {
                VariationsTable(
                    isVariation: true,
                    cards: [variationSource],
                    onCardSelected: { card in
                        print("\(model.card.id) -> \(card.id)")
                        model.card = card
                    }
                )
            } else if case let variations = model.variations, !variations.isEmpty {
                VariationsTable(
                    isVariation: false,
                    cards: variations,
                    onCardSelected: { card in
                        model.card = card
                    }
                )
            }
        }
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
