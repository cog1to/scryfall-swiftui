//
//  ItalicTextView.swift
//  Scryfall
//
//  Created by Alexander on 22.08.2021.
//

import Foundation
import SwiftUI

struct ItalicTextView: View {

    let text: String

    var body: some View {
        HStack {
            Text(text)
                .font(Style.Fonts.italic)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
        .padding(.top, Style.listElementPadding)
        .padding(.horizontal, Style.listElementHorizontalPadding)
        .padding(.bottom, Style.listElementPadding)
    }
}
