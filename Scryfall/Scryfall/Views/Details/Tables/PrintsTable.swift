//
//  PrintsTable.swift
//  Scryfall
//
//  Created by Alexander on 28.08.2021.
//

import Foundation
import SwiftUI
import ScryfallModel
import UIKit

struct PrintsTable: View {
    let cards: [Card]
    let currentCard: Card
    let onCardSelected: ((Card) -> ())?
    let onAllPrintsSelected: (() -> ())?

    init(
        cards: [Card],
        currentCard: Card,
        onCardSelected: ((Card) -> ())? = nil,
        onAllPrintsSelected: (() -> ())? = nil
    ) {
        self.cards = cards.sorted { $0.number < $1.number }
        self.currentCard = currentCard
        self.onCardSelected = onCardSelected
        self.onAllPrintsSelected = onAllPrintsSelected
    }

    var body: some View {
        VStack(spacing: 0) {
            PrintHeader()
                .frame(height: rowHeight)
            VStack(spacing: 0.5) {
                ForEach(visibleSection) { card in
                    PrintRow(
                        card: card,
                        isSelected: card.id == currentCard.id,
                        showNumber: cards.filter { $0.set == card.set }.count > 1
                    )
                    .frame(maxHeight: rowHeight)
                    .onTapGesture {
                        onCardSelected?(card)
                    }
                }
                if cards.count > 1 {
                    AllPrintsRow()
                        .onTapGesture {
                            onAllPrintsSelected?()
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

    var rowHeight: CGFloat {
        return UIFontMetrics(forTextStyle: .body).scaledValue(for: Style.Fonts.smallFontSize) + 16
    }
}

struct PrintHeader: View {
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: rowSpacing) {
                ZStack {
                    Text("Prints".uppercased())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color("BrightText"))
                        .font(Style.Fonts.small)
                }
                .frame(width: titleWidth(proxy.size.width))

                ZStack {
                    Text("USD".uppercased())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(Color("BrightText"))
                        .font(Style.Fonts.small)
                }
                .frame(maxWidth: colWidth(proxy.size.width))

                ZStack {
                    Text("EUR".uppercased())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(Color("BrightText"))
                        .font(Style.Fonts.small)
                }
                .frame(maxWidth: colWidth(proxy.size.width))

                ZStack {
                    Text("TIX".uppercased())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(Color("BrightText"))
                        .font(Style.Fonts.small)
                }
                .frame(maxWidth: colWidth(proxy.size.width))
            }
            .padding(rowPadding)
            .frame(height: rowHeight)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color("Accent"))
    }

    func colWidth(_ width: CGFloat) -> CGFloat {
        (width - titleWidth(width) - rowPadding * 2 - rowSpacing * 3) / 3.0
    }

    func titleWidth(_ width: CGFloat) -> CGFloat {
        (width > 768)
            ? 400
            : (width * 0.45)
    }

    // MARK: - Config

    var rowPadding: CGFloat = 8

    var rowSpacing: CGFloat = 4

    var rowHeight: CGFloat {
        return UIFontMetrics(forTextStyle: .body)
            .scaledValue(for: Style.Fonts.smallFontSize) + rowPadding * 2
    }
}

struct PrintRow: View {
    let card: Card
    let isSelected: Bool
    let showNumber: Bool

    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: rowPadding) {
                ZStack(alignment: .leading) {
                    Text(card.setName + (showNumber ? " #\(card.number)" : ""))
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Style.Fonts.small)
                        .padding(.leading, 6)

                    RaritySymbol(rarity: card.rarity)
                        .frame(width: 18, height: 18)
                        .offset(CGSize(width: -17, height: 0))
                }
                .frame(width: titleWidth(proxy.size.width))
                // TODO: Deal with very small screens + Long price tags
                // Example: !"Ancestral Recall" r:bonus

                ZStack {
                    Text(usdPrice)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(Style.Fonts.small)
                        .foregroundColor(Color("PriceUSD"))
                }
                .frame(maxWidth: colWidth(proxy.size.width))

                ZStack {
                    Text(eurPrice)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(Style.Fonts.small)
                        .foregroundColor(Color("PriceEUR"))
                }
                .frame(maxWidth: colWidth(proxy.size.width))

                ZStack {
                    Text(tixPrice)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(Style.Fonts.small)
                        .foregroundColor(Color("PriceTIX"))
                }
                .frame(maxWidth: colWidth(proxy.size.width))
            }
            .padding(rowPadding)
            .frame(height: rowHeight)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                isSelected ? Color("Selected") : Color("White")
            )
        }
    }

    var usdPrice: String {
        if let usdString = card.prices.usd {
            return "$\(usdString)"
        } else if let foilString = card.prices.usdFoil {
            return "✶ $\(foilString)"
        } else {
            return ""
        }
    }

    var eurPrice: String {
        if let eurPrice = card.prices.eur {
            return "€\(eurPrice)"
        } else if let foilString = card.prices.eurFoil {
            return "✶ €\(foilString)"
        } else {
            return ""
        }
    }

    var tixPrice: String {
        if let tixPrice = card.prices.tix {
            return "\(tixPrice)"
        } else {
            return ""
        }
    }

    func colWidth(_ width: CGFloat) -> CGFloat {
        (width - titleWidth(width) - rowPadding * 2 - rowSpacing * 3) / 3.0
    }

    func titleWidth(_ width: CGFloat) -> CGFloat {
        (width > 768)
            ? 400
            : (width * 0.45)
    }

    // MARK: - Config

    var rowPadding: CGFloat = 8

    var rowSpacing: CGFloat = 4

    var rowHeight: CGFloat {
        return UIFontMetrics(forTextStyle: .body)
            .scaledValue(for: Style.Fonts.smallFontSize) + rowPadding * 2
    }
}

struct AllPrintsRow: View {
    var body: some View {
        HStack(spacing: 4) {
            ZStack {
                Text("View all prints →")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Style.Fonts.small)
                    .padding(.leading, 6)
            }
            .frame(minWidth: 240)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .background(Color("White"))
    }
}

struct RaritySymbol: View {
    let rarity: Rarity

    var body: some View {
        Image("Star")
            .padding(3)
            .foregroundColor(rarity.color)
            .background(Color("White"))
            .clipShape(Circle())
            .overlay(Circle().stroke(Color("Gray"), lineWidth: 0.5))
    }
}

struct PrintsTable_Previews: PreviewProvider {
    static var previews: some View {
        PrintsTable(
            cards: [ModelStubs.avacyn, ModelStubs.avacyn, ModelStubs.avacyn],
            currentCard: ModelStubs.avacyn,
            onCardSelected: nil
        )
    }
}
