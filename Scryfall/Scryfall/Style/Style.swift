//
//  Style.swift
//  Scryfall
//
//  Created by Alexander on 06.07.2021.
//

import Foundation
import UIKit
import SwiftUI

class Style {

    // MARK: - Common measurements

    static let listElementPadding: CGFloat = 8.0
    static let listElementHorizontalPadding: CGFloat = 12.0

    // MARK: - Font styles

    enum Fonts {
        static func main() -> Font {
            Font.custom("Lato-Regular", size: 17, relativeTo: .body)
        }

        static func title() -> Font {
            Font.custom("Lato-Bold", size: 17, relativeTo: .body)
        }
    }
}
