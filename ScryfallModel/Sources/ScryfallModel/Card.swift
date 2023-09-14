//
//  Card.swift
//
//
//  Created by Alexander on 26.06.2021.
//

import Foundation

public final class Card: Identifiable, Codable {

    // MARK: - Required fields

    public var id: String
    public var lang: Language
    public var oracleId: String
    public var printsSearchUri: URL
    public var rulingsUri: URL
    public var scryfallUri: URL
    public var uri: URL

    // MARK: - Optional fields

    public var arenaId: Int?
    public var mtgoId: Int?
    public var mtgoFoilId: Int?
    public var multiverseIds: [Int]?
    public var tcgplayerId: Int?
    public var cardmarketId: Int?
    public var imageUris: ImageList?
    public var cardFaces: [CardFace]?
    public var legalities: LegalityList?
    public var printedTypeLine: String?
    public var printedName: String?
    public var printedText: String?
    public var flavorText: String?
    public var allParts: [RelatedCard]?
    public var variation: Bool
    public var variationOfId: String?
    public var flavorName: String?
    public var cardBackId: String?

    // MARK: - Gameplay field

    public var cmc: Double
    public var colorIndicator: [Color]?
    public var colorIdentity: [Color]
    public var colors: [Color]?
    public var foil: Bool
    public var layout: String
    public var name: String
    public var oracleText: String?
    public var manaCost: String?
    public var power: String?
    public var toughness: String?
    public var typeline: String?
    public var loyalty: String?
    public var artist: String?
    public var set: String
    public var setName: String
    public var number: String
    public var rarity: Rarity

    // MARK: - Prices

    public var prices: CardPrices

    // MARK: - Decodable

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case lang = "lang"
        case oracleId = "oracle_id"
        case printsSearchUri = "prints_search_uri"
        case rulingsUri = "rulings_uri"
        case scryfallUri = "scryfall_uri"
        case uri = "uri"
        case arenaId = "arena_id"
        case mtgoId = "mtgo_id"
        case mtgoFoilId = "mtgo_foil_id"
        case multiverseIds = "multiverse_ids"
        case tcgplayerId = "tcgplayer_id"
        case cardmarketId = "cardmarket_id"
        case cmc = "cmc"
        case colorIndicator = "color_indicator"
        case colorIdentity = "color_identity"
        case colors = "colors"
        case foil = "foil"
        case layout = "layout"
        case name = "name"
        case manaCost = "mana_cost"
        case oracleText = "oracle_text"
        case power = "power"
        case toughness = "toughness"
        case typeline = "type_line"
        case imageUris = "image_uris"
        case cardFaces = "card_faces"
        case loyalty = "loyalty"
        case artist = "artist"
        case legalities = "legalities"
        case set = "set"
        case setName = "set_name"
        case number = "collector_number"
        case rarity = "rarity"
        case printedText = "printed_text"
        case printedName = "printed_name"
        case printedTypeLine = "printed_type_line"
        case flavorText = "flavor_text"
        case prices = "prices"
        case allParts = "all_parts"
        case variation = "variation"
        case variationOfId = "variation_of"
        case flavorName = "flavor_name"
        case cardBackId = "card_back_id"
    }
}
