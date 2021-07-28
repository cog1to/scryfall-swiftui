//
//  Catalog.swift
//  
//
//  Created by Alexander on 28.07.2021.
//

import Foundation

public class Catalog<T: Codable>: Codable {

    // MARK: - Properties

    public let data: [T]

    // MARK: - Coding

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }

    // MARK: - Init

    init() {
        self.data = []
    }

    public static func empty() -> Catalog<T> {
        return Catalog<T>()
    }
}
