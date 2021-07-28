//
//  List.swift
//  
//
//  Created by Alexander on 06.07.2021.
//

import Foundation

public class ObjectList<T: Codable>: Codable {

    // MARK: - Properties

    public let hasMore: Bool
    public let nextPage: URL?
    public let data: [T]

    // MARK: - Coding

    enum CodingKeys: String, CodingKey {
        case hasMore = "has_more"
        case nextPage = "next_page"
        case data = "data"
    }

    // MARK: - Init

    init() {
        self.hasMore = false
        self.data = []
        self.nextPage = nil
    }

    public static func empty() -> ObjectList<T> {
        return ObjectList<T>()
    }
}
