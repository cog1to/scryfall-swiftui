//
//  Set.swift
//  
//
//  Created by Alexander on 02.07.2021.
//

import Foundation

public final class CardSet: Identifiable, Codable {
    public var id: String
    public var code: String
    public var mtgoCode: String?
    public var tcgplayerId: Int?
    public var name: String
    public var setType: String
    public var releasedAt: Date?
    public var blockCode: String?
    public var block: String?
    public var parentSetCode: String?
    public var cardCount: Int
    public var printedSize: Int
    public var digital: Bool
    public var foilOnly: Bool
    public var nonfoilOnly: Bool
    public var scryfallUri: URL?
    public var uri: URL?
    public var iconSvgUri: URL?
    public var searchUri: URL?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case code = "code"
        case mtgoCode = "mtgo_code"
        case tcgplayerId = "tcgplayer_id"
        case name = "name"
        case setType = "set_type"
        case releasedAt = "release_at"
        case blockCode = "block_code"
        case block = "block"
        case parentSetCode = "parent_set_code"
        case cardCount = "card_count"
        case printedSize = "printed_size"
        case digital = "digital"
        case foilOnly = "foil_only"
        case nonfoilOnly = "nonfoil_only"
        case scryfallUri = "scryfall_uri"
        case uri = "uri"
        case iconSvgUri = "icon_svg_uri"
        case searchUri = "search_uri"
    }
}
