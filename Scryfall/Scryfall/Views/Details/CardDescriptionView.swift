//
//  CardDescriptionView.swift
//  Scryfall
//
//  Created by Alexander on 11.08.2021.
//

import SwiftUI

import SwiftUI
import ScryfallModel

struct CardDescriptionView: View {
    let card: Card
    let provider: SymbolProvider

    var body: some View {
        ZStack(alignment: .bottom) {
            Color("Black")
                .frame(height: 3)

            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    if let cardFaces = card.cardFaces, !cardFaces.isEmpty {
                        ForEach(cardFaces) { face in
                            CardFaceView(
                                name: face.name,
                                manaCost: face.manaCost,
                                typeLine: face.typeline,
                                colorIndicator: face.colorIndicator,
                                oracleText: face.oracleText,
                                power: face.power,
                                toughness: face.toughness,
                                loyalty: face.loyalty,
                                provider: provider
                            )
                        }
                    } else {
                        CardFaceView(
                            name: card.name,
                            manaCost: card.manaCost,
                            typeLine: card.typeline,
                            colorIndicator: card.colorIndicator,
                            oracleText: card.oracleText,
                            power: card.power,
                            toughness: card.toughness,
                            loyalty: card.loyalty,
                            provider: provider
                        )
                    }

                    if let artist = card.artist {
                        Divider()
                        HStack {
                            LinkTextView(prefix: "Illustrated by ", link: artist)
                            Spacer()
                        }
                        .padding(.top, Style.listElementPadding + 2)
                        .padding(.bottom, Style.listElementPadding + 2)
                        .padding(.horizontal, Style.listElementHorizontalPadding)
                    }

                    SectionDivider()
                        .padding(.bottom, 4)

                    LegalityTable(legalities: card.legalities!)
                        .padding(.top, Style.listElementPadding)
                        .padding(.bottom, Style.listElementPadding)
                        .padding(.horizontal, Style.listElementHorizontalPadding)
                }
                .padding(.bottom, Style.listElementPadding)
                .border(Color.gray, width: 1)

                Color("Black")
                    .frame(height: 3)
            }
        }
        .cornerRadius(6)
    }
}

struct CardDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            CardDescriptionView(
                card: ModelStubs.abominationOfGudul,
                provider: DefaultSymbolProvider(
                    fileCache: ImageCache(),
                    viewModel: CommonViewModel(client: StubClient())
                )
            )
        }
    }
}
