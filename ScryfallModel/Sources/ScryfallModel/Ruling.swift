//
//  Ruling.swift
//  
//
//  Created by Alexander on 30.08.2021.
//

import Foundation

public final class Ruling: Codable, Identifiable {
    public let oracleId: String
    public let source: String?
    public let publishedAt: String
    public let comment: String

    public var id: String {
        comment
    }

    enum CodingKeys: String, CodingKey {
        case oracleId = "oracle_id"
        case source = "source"
        case publishedAt = "published_at"
        case comment = "comment"
    }

    public init(id: String, source: String?, published: String, comment: String) {
        self.oracleId = id
        self.source = source
        self.publishedAt = published
        self.comment = comment
    }
}
