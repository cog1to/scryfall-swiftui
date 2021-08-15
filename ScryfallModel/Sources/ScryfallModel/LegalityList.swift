//
//  LegalityList.swift
//  
//
//  Created by Alexander on 13.08.2021.
//

import Foundation

public final class LegalityList: Codable {
    public enum Legality: String, Codable {
        case legal = "legal"
        case notLegal = "not_legal"
        case banned = "banned"
        case restricted = "restricted"
    }

    public let standard: Legality
    public let future: Legality
    public let historic: Legality
    public let gladiator: Legality
    public let pioneer: Legality
    public let modern: Legality
    public let legacy: Legality
    public let pauper: Legality
    public let vintage: Legality
    public let penny: Legality
    public let commander: Legality
    public let brawl: Legality
    public let duel: Legality
    public let oldschool: Legality
    public let premodern: Legality

    enum CodingKeys: String, CodingKey {
        case standard = "standard"
        case future = "future"
        case historic = "historic"
        case gladiator = "gladiator"
        case pioneer = "pioneer"
        case modern = "modern"
        case legacy = "legacy"
        case pauper = "pauper"
        case vintage = "vintage"
        case penny = "penny"
        case commander = "commander"
        case brawl = "brawl"
        case duel = "duel"
        case oldschool = "oldschool"
        case premodern = "premodern"
    }
}
