//
//  Line.swift
//  Scryfall
//
//  Created by Alexander on 30.08.2021.
//

import SwiftUI

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct DashedLine: View {
    var body: some View {
        Line()
            .stroke(style: StrokeStyle(lineWidth: 0.5, dash: [5]))
            .frame(height: 0.5)
    }
}
