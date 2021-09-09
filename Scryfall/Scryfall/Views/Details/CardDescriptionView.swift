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
                                name: face.printedName ?? face.name,
                                flavorName: nil,
                                manaCost: face.manaCost,
                                typeLine: face.printedTypeLine ?? face.typeline,
                                colorIndicator: face.colorIndicator,
                                oracleText: face.printedText ?? face.oracleText,
                                flavorText: face.flavorText,
                                power: face.power,
                                toughness: face.toughness,
                                loyalty: face.loyalty,
                                language: card.lang,
                                provider: provider
                            )
                        }
                    } else {
                        CardFaceView(
                            name: (card.flavorName != nil
                                    ? card.name
                                    : (card.printedName ?? card.name)),
                            flavorName: card.flavorName,
                            manaCost: card.manaCost,
                            typeLine: card.printedTypeLine ?? card.typeline,
                            colorIndicator: card.colorIndicator,
                            oracleText: card.printedText ?? card.oracleText,
                            flavorText: card.flavorText,
                            power: card.power,
                            toughness: card.toughness,
                            loyalty: card.loyalty,
                            language: card.lang,
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
