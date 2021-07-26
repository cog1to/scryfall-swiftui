//
//  List.swift
//  
//
//  Created by Alexander on 06.07.2021.
//

import Foundation

public class List<T: Codable>: Codable {
    public let hasMore: Bool
    public let nextPage: URL?
    public let data: [T]

    enum CodingKeys: String, CodingKey {
        case hasMore = "has_more"
        case nextPage = "next_page"
        case data = "data"
    }
}
