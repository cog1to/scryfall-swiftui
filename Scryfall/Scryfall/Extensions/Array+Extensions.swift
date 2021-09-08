//
//  Array+Extensions.swift
//  Scryfall
//
//  Created by Alexander on 08.09.2021.
//

import Foundation

extension Array {
    func unique<T: Equatable>(keyPath: KeyPath<Element, T>) -> [Element] {
        var uniqueKeys = [T]()
        var result = [Element]()

        for item in self {
            if !uniqueKeys.contains(item[keyPath: keyPath]) {
                uniqueKeys.append(item[keyPath: keyPath])
                result.append(item)
            }
        }

        return result
    }
}
