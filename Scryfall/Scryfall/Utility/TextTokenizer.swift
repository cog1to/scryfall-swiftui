//
//  TextTokenizer.swift
//  Scryfall
//
//  Created by Alexander on 25.07.2021.
//

import Foundation
import ScryfallModel

enum TextToken {
    case plain(String)
    case symbol(String)
}

extension String {
    func tokenize() -> [TextToken] {
        let pattern = "\\{[A-Z0-9½∞/]+\\}"

        var output: [TextToken] = []
        var previous: Range<Index>? = nil
        var range = self.range(of: pattern, options: .regularExpression, range: previous, locale: nil)

        guard range != nil else {
            return [.plain(self)]
        }

        while range != nil {
            // Extract string before the range
            let prefix = self[(previous?.upperBound ?? self.startIndex) ..< (range!.lowerBound)]
            output.append(.plain(String(prefix)))

            // Add the range itself
            let symbol = self[range!.lowerBound ..< range!.upperBound]
            output.append(.symbol(String(symbol)))

            // Next iteration
            previous = range

            range = self.range(
                of: pattern,
                options: .regularExpression,
                range: (range!.upperBound ..< self.endIndex),
                locale: nil
            )
        }

        // Add suffix
        if let previous = previous, previous.upperBound < self.endIndex {
            let suffix = self[previous.upperBound ..< self.endIndex]
            output.append(.plain(String(suffix)))
        }

        return output
    }
}
