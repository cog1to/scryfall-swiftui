//
//  VariationsTable.swift
//  Scryfall
//
//  Created by Alexander on 05.09.2021.
//

import Foundation
import SwiftUI
import ScryfallModel

struct VariationsTable: View {
    let isVariation: Bool
    let cards: [Card]
    let onCardSelected: ((Card) -> ())?

    var body: some View {
        VStack(spacing: 0) {
            VariationsHeader(isVariation: isVariation)
            VStack(spacing: 0.5) {
                ForEach(visibleSection) { card in
                    VariationItemRow(card: card, isSelected: false)
                        .onTapGesture {
                            onCardSelected?(card)
                        }
                }
            }
            .padding(.leading, 0.5)
            .background(Color("Gray"))
            footer
        }
    }

    var footer: some View {
        Color("Accent")
            .frame(maxWidth: .infinity)
            .frame(height: 3)
    }

    var visibleSection: [Card] {
        guard cards.count > 10 else { return cards }
        return [Card](cards.prefix(10))
    }
}

struct VariationsHeader: View {
    let isVariation: Bool

    var body: some View {
        HStack(spacing: 4) {
            ZStack {
                Text((isVariation ? "Variation of" : "Variations").uppercased())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color("BrightText"))
                    .font(Style.Fonts.small)
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(8)
        .background(Color("Accent"))
    }
}

struct VariationItemRow: View {
    let card: Card
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 4) {
            ZStack(alignment: .leading) {
                Text("\(name), \(card.set.uppercased()) #\(card.number)")
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Style.Fonts.small)
                    .padding(.leading, 6)

                RaritySymbol(rarity: card.rarity)
                    .frame(width: 18, height: 18)
                    .offset(CGSize(width: -17, height: 0))
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(
            isSelected ? Color("Selected") : Color("White")
        )
    }

    var name: String {
        card.name + (card.layout == "token" ? " Token" : "")
    }
}

struct VariationsTable_Previews: PreviewProvider {
    static var previews: some View {
        VariationsTable(
            isVariation: false,
            cards: [ModelStubs.avacyn],
            onCardSelected: nil
        )
    }
}

