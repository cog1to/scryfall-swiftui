//
//  Spinner.swift
//  Scryfall
//
//  Created by Alexander on 30.07.2021.
//

import Foundation
import UIKit
import SwiftUI

struct Spinner: UIViewRepresentable {
    let isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<Spinner>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Spinner>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
