//
//  CardPrices.swift
//  
//
//  Created by Alexander on 28.08.2021.
//

import Foundation

public final class CardPrices: Codable {
    public let usd: String?
    public let usdFoil: String?
    public let eur: String?
    public let eurFoil: String?
    public let tix: String?

    enum CodingKeys: String, CodingKey {
        case usd = "usd"
        case usdFoil = "usd_foil"
        case eur = "eur"
        case eurFoil = "eur_foil"
        case tix = "tix"
    }
}
