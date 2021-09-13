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

        static let small: Font = {
            Font.custom("Lato-Regular", size: Self.smallFontSize, relativeTo: .body)
        }()

        static let smallFixed: Font = {
            Font.custom("Lato-Regular", fixedSize: Self.smallFontSize)
        }()

        static let subtitle: Font = {
            Font.custom("Lato-Regular", size: 16, relativeTo: .body)
        }()

        static let ruling: Font = {
            Font.custom("Lato-Regular", size: 14, relativeTo: .body)
        }()

        static let rulingSubtitle: Font = {
            Font.custom("mplantin-italic", size: 15, relativeTo: .body)
        }()

        static let rulingHeavy: Font = {
            Font.custom("Lato-Bold", size: 14, relativeTo: .body)
        }()

        static var uiSmall: UIFont {
            UIFont(
                name: "Lato-Regular",
                size: UIFontMetrics(forTextStyle: .body).scaledValue(for: Self.smallFontSize)
            )!
        }

        static let phyrexian: Font = {
            Font.custom("Phi_horizontal_gbrsh_9.7", size: 17, relativeTo: .body)
        }()

        // MARK: - Italics

        static let flavor: Font = {
            Font.custom("mplantin-italic", size: Self.flavorFontSize, relativeTo: .body)
        }()

        static let flavorCyrillic: Font = {
            return Font.custom("Georgia", size: 17, relativeTo: .body).italic()
        }()

        static let flavorHieroglyphic: Font = {
            var matrix = CGAffineTransform(
                a: 1.0,
                b: 0.0,
                c: CGFloat(tanf(15.0 * Float.pi / 180.0)),
                d: 1.0,
                tx: 0.0,
                ty: 0.0
            )

            let fontSize = UIFontMetrics(forTextStyle: .body).scaledValue(for: Self.flavorFontSize)
            let desc = UIFontDescriptor(name: "Sans", size: fontSize)
            let ctFont: CTFont = withUnsafePointer(to: &matrix) { matrix -> CTFont in
                return CTFontCreateWithFontDescriptor(desc, fontSize, matrix)
            }
            return Font(ctFont)
        }()

        static let italic: Font = {
            Font.custom("mplantin-italic", size: 19, relativeTo: .body)
        }()

        static let italicCyrillic: Font = {
            return Font.custom("Georgia", size: 17, relativeTo: .body).italic()
        }()

        // MARK: - Sizes

        static let smallFontSize: CGFloat = 12

        static let flavorFontSize: CGFloat = 19
    }
}
