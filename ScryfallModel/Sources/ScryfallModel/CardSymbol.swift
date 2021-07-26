//
//  CardSymbol.swift
//  
//
//  Created by Alexander on 08.07.2021.
//

import Foundation

public final class CardSymbol: Codable, Identifiable {
    public let symbol: String
    public let svgUri: URL

    public var id: String {
        symbol
    }

    enum CodingKeys: String, CodingKey {
        case symbol = "symbol"
        case svgUri = "svg_uri"
    }
}
