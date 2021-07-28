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
                                manaCost: face.manaCost,
                                typeLine: face.typeline,
                                colorIndicator: face.colorIndicator,
                                oracleText: face.oracleText,
                                power: face.power,
                                toughness: face.toughness,
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
