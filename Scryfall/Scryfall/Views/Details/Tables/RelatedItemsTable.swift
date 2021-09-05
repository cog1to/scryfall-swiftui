//
//  RelatedItemsTable.swift
//  Scryfall
//
//  Created by Alexander on 05.09.2021.
//

import Foundation
import SwiftUI
import ScryfallModel

struct RelatedItemsTable: View {
    let cards: [Card]
    let currentCard: Card
    let onCardSelected: ((Card) -> ())?

    var body: some View {
        VStack(spacing: 0) {
            RelatedItemsHeader()
            VStack(spacing: 0.5) {
                ForEach(visibleSection) { card in
                    RelatedItemRow(card: card, isSelected: card.id == currentCard.id)
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
        guard cards.count > 10
            else { return cards }

        guard let currentIndex = cards.firstIndex(where: { $0.id == currentCard.id })
            else { return [Card](cards.prefix(10)) }

        let startIndex = max(0, currentIndex - 4)
        let endIndex = min(startIndex + 10, cards.count)

        return [Card](cards[startIndex..<endIndex])
    }
}

struct RelatedItemsHeader: View {
    var body: some View {
        HStack(spacing: 4) {
            ZStack {
                Text("Faces, Tokens, & Other Parts".uppercased())
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

struct RelatedItemRow: View {
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

struct RelatedItemsTable_Previews: PreviewProvider {
    static var previews: some View {
        RelatedItemsTable(
            cards: [],
            currentCard: ModelStubs.avacyn,
            onCardSelected: nil
        )
    }
}

