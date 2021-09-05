//
//  RelatedCard.swift
//  
//
//  Created by Alexander on 05.09.2021.
//

import Foundation

public class RelatedCard: Codable, Identifiable {
    public let id: String
    public let component: String?
    public let name: String
    public let typeLine: String
    public let uri: URL

    // MARK: - Coding

    enum CodingKeys: String, CodingKey {
        case id
        case component
        case name
        case typeLine = "type_line"
        case uri
    }
}
