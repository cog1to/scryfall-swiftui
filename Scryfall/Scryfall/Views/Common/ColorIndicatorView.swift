//
//  ColorIndicatorView.swift
//  Scryfall
//
//  Created by Alexander on 06.07.2021.
//

import Foundation
import ScryfallModel
import SwiftUI

struct ColorIndicatorView: View {
    let colors: [ScryfallModel.Color]

    var body: some View {
        GeometryReader { geometry in
//            let halfWidth = (geometry.size.width / 2)
//            let halfHeight = (geometry.size.height / 2)
//            let radius = min(halfWidth, halfHeight)
//            let center = CGPoint(x: halfWidth, y: halfHeight)

            ZStack {
                Circle()
                    .foregroundColor(Color("Gray"))

                if colors.count == 1, let color = colors.first {
                    Circle()
                        .strokeBorder(Color.black, lineWidth: 1.0 / UIScreen.main.scale)
                        .background(Circle().foregroundColor(color.uiColor))
                        .padding(2)
                } else if colors.count == 2 {

                } else {

                }
            }
        }
    }
}
