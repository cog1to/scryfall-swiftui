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

    func makeUIView(context: Context) -> UIImageView {
        let image = SVGKImage(contentsOf: url)
        image?.scaleToFit(inside: CGSize(width: 30, height: 30))

        let view = UIImageView(image: image?.uiImage.withTintColor(.white, renderingMode: .alwaysTemplate))
        view.contentMode = .scaleAspectFit
        view.tintColor = .white

        return view
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        let image = SVGKImage(contentsOf: url)
        image?.scaleToFit(inside: CGSize(width: 30, height: 30))

        uiView.image = image?.uiImage.withTintColor(.white, renderingMode: .alwaysTemplate)
    }
}
