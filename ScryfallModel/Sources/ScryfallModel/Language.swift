//
//  Language.swift
//  
//
//  Created by Alexander on 14.08.2021.
//

import Foundation

public enum Language: Codable, RawRepresentable {
    public typealias RawValue = String

    case english
    case spanish
    case french
    case german
    case italian
    case portuguese
    case japanese
    case korean
    case russian
    case chineseSimplified
    case chineseTraditional
    case hebrew
    case latin
    case antientGreek
    case arabic
    case sanskrit
    case phyrexian
    case unknown(String)

    public init?(rawValue: String) {
        switch rawValue {
        case "en": self = .english
        case "sp": self = .spanish
        case "fr": self = .french
        case "de": self = .german
        case "it": self = .italian
        case "pt": self = .portuguese
        case "jp": self = .japanese
        case "ko": self = .korean
        case "ru": self = .russian
        case "zhs": self = .chineseSimplified
        case "zht": self = .chineseTraditional
        case "he": self = .hebrew
        case "la": self = .latin
        case "grc": self = .antientGreek
        case "ar": self = .arabic
        case "sa": self = .sanskrit
        case "phy": self = .phyrexian
        default:
            self = .unknown(rawValue)
        }
    }

    public var rawValue: String {
        switch self {
        case .english: return "en"
        case .french: return "fr"
        case .spanish: return "sp"
        case .german: return "de"
        case .portuguese: return "pt"
        case .italian: return "it"
        case .japanese: return "jp"
        case .korean: return "ko"
        case .russian: return "ru"
        case .chineseSimplified: return "zhs"
        case .chineseTraditional: return "zht"
        case .hebrew: return "he"
        case .latin: return "la"
        case .antientGreek: return "grc"
        case .arabic: return "ar"
        case .sanskrit: return "sa"
        case .phyrexian: return "phy"
        case let .unknown(lang): return lang
        }
    }



    public var title: String {
        switch self {
        case .english: return "English"
        case .french: return "French"
        case .german: return "German"
        case .italian: return "Italian"
        case .portuguese: return "Portuguese"
        case .japanese: return "Japanese"
        case .korean: return "Korean"
        case .chineseSimplified: return "Simplified Chinese"
        case .chineseTraditional: return "Traditional Chinese"
        case .russian: return "Russian"
        case .arabic: return "Arabic"
        case .hebrew: return "Hebrew"
        case .sanskrit: return "Sanskrit"
        case .antientGreek: return "Ancient Greek"
        case .latin: return "Latin"
        case .phyrexian: return "Phyrexian"
        case .spanish: return "Spanish"
        case let .unknown(lang): return lang.uppercased()
        }
    }

    public var abbreviation: String {
        switch self {
        case .english: return "EN"
        case .french: return "FR"
        case .german: return "DE"
        case .italian: return "IT"
        case .portuguese: return "PT"
        case .japanese: return "JA"
        case .korean: return "KR"
        case .chineseSimplified: return "汉语"
        case .chineseTraditional: return "漢語"
        case .russian: return "RU"
        case .arabic: return "AR"
        case .hebrew: return "HE"
        case .sanskrit: return "SA"
        case .antientGreek: return "GRC"
        case .latin: return "LA"
        case .phyrexian: return "PH"
        case .spanish: return "SP"
        case let .unknown(lang): return lang.uppercased()
        }
    }
}
