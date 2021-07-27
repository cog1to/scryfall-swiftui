//
//  ColorIndicatorView.swift
//  Scryfall
//
//  Created by Alexander on 06.07.2021.
//

import Foundation
import UIKit
import ScryfallModel
import SwiftUI

struct ColorIndicatorSlice: View {
    var center: CGPoint
    var radius: CGFloat
    var startDegree: Double
    var endDegree: Double
    var fillColor: SwiftUI.Color

    var path: Path {
        var path = Path()
        path.addArc(
            center: center,
            radius: radius,
            startAngle: Angle(degrees: startDegree),
            endAngle: Angle(degrees: endDegree),
            clockwise: false
        )
        path.addLine(to: center)
        path.closeSubpath()
        return path
    }

    var body: some View {
        path.fill(fillColor)
    }
}

struct ColorIndicatorView: View {
    let colors: [ScryfallModel.Color]

    var body: some View {
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            let radius = min(geometry.size.width / 2, geometry.size.height / 2)
            let offset: Double = (-360.0 / Double(colors.count)) - 90.0

            ZStack {
                Circle()
                    .foregroundColor(Color("Gray"))

                ForEach(0..<colors.count, id: \.self) { index in
                    ColorIndicatorSlice(
                        center: center,
                        radius: radius - 2,
                        startDegree: (360.0 / Double(colors.count)) * Double(index) + offset,
                        endDegree: (360.0 / Double(colors.count)) * Double(index + 1) + offset,
                        fillColor: colors[index].uiColor
                    )
                }

                Circle()
                    .strokeBorder(Color.black, lineWidth: 1.0 / UIScreen.main.scale)
                    .padding(2)
            }
        }
    }
}
