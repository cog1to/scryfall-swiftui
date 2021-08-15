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
    static let listElementBottomPadding: CGFloat = 8.0
    static let listElementHorizontalPadding: CGFloat = 12.0
    static let listSpacing: CGFloat = 10.0
    static let cardSize = CGSize(width: 200, height: 280)

    // MARK: - Font styles

    enum Fonts {
        static let main: Font = {
            Font.custom("Lato-Regular", size: 17, relativeTo: .body)
        }()

        static let title: Font = {
            Font.custom("Lato-Bold", size: 17, relativeTo: .body)
        }()

        static let italic: Font = {
            Font.custom("mplantin-italic", size: 19, relativeTo: .body)
        }()

        static let small: Font = {
            Font.custom("Lato-Regular", size: 12, relativeTo: .body)
        }()

        static let smallFixed: Font = {
            Font.custom("Lato-Regular", fixedSize: 12)
        }()

        static let subtitle: Font = {
            Font.custom("Lato-Regular", size: 16, relativeTo: .body)
        }()
    }
}
