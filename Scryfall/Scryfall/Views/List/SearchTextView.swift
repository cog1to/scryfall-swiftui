//
//  SearchTextView.swift
//  Scryfall
//
//  Created by Alexander on 06.07.2021.
//

import SwiftUI
import ScryfallModel

struct SearchTextView: View {
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
                                flavorName: nil,
                                manaCost: face.manaCost,
                                typeLine: face.typeline,
                                colorIndicator: face.colorIndicator,
                                oracleText: face.oracleText,
                                flavorText: nil,
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
                                : card.printedName ?? card.name),
                            flavorName: card.flavorName,
                            manaCost: card.manaCost,
                            typeLine: card.typeline,
                            colorIndicator: card.colorIndicator,
                            oracleText: card.oracleText,
                            flavorText: nil,
                            power: card.power,
                            toughness: card.toughness,
                            loyalty: card.loyalty,
                            language: card.lang,
                            provider: provider
                        )
                    }
                    Spacer()
                }
                .border(Color.gray, width: 1)

                Color("Black")
                    .frame(height: 3)
            }
        }
        .cornerRadius(6)
    }
}

struct SearchTextView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            SearchTextView(
                card: ModelStubs.abominationOfGudul,
                provider: DefaultSymbolProvider(
                    fileCache: ImageCache(),
                    viewModel: CommonViewModel(client: StubClient())
                )
            )
        }
    }
}
