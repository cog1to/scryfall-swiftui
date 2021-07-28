//
//  CardFace.swift
//
//
//  Created by Alexander on 26.06.2021.
//

import Foundation

public final class CardFace: Codable, Identifiable {

    // MARK: - Required fields

    public var name: String
    public var manaCost: String
    public var typeline: String

    // MARK: - Optional fields

    public var power: String?
    public var toughness: String?
    public var watermark: String?
    public var printedName: String?
    public var printedText: String?
    public var printedTypeLine: String?
    public var artist: String?
    public var colorIndicator: [Color]?
    public var colors: [Color]?
    public var flavorText: String?
    public var illustrationId: String?
    public var loyalty: String?
    public var oracleText: String?
    public var imageUris: ImageList?

    // MARK: - Identifiable

    public var id: String {
        name
    }

    // MARK: - Decoding

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case manaCost = "mana_cost"
        case typeline = "type_line"
        case power = "power"
        case toughness = "toughness"
        case printedName = "printed_name"
        case printedText = "printed_text"
        case printedTypeLine = "printed_type_line"
        case artist = "artist"
        case colorIndicator = "color_indicator"
        case colors = "colors"
        case flavorText = "flavor_text"
        case illustrationId = "illustration_id"
        case loyalty = "loyalty"
        case oracleText = "oracle_text"
        case imageUris = "image_uris"
        case watermark = "watermark"
    }
}
