//
//  DynamicImage.swift
//  Scryfall
//
//  Created by Alexander on 11.07.2021.
//

import SwiftUI
import Combine
import SVGKit
import SVGKitSwift

struct SVGImageView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> SVGKImageView {
        let image = SVGKImage(contentsOf: url)
        let view = SVGKImageView(svgkImage: image)!
        return view
    }

    func updateUIView(_ uiView: SVGKImageView, context: Context) {
        uiView.image = SVGKImage(contentsOf: url)
    }
}
