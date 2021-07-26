//
//  ParagraphView.swift
//  Scryfall
//
//  Created by Alexander on 06.07.2021.
//

import Foundation
import SwiftUI
import ScryfallModel

struct ParagraphView: View {

    let text: String

    let provider: SymbolProvider

    var body: some View {
        VStack(spacing: 0) {
            ForEach(paragraphs) { par in
                HStack {
                    MagicTextView(text: par.text, bold: false, provider: provider)
                        .lineLimit(nil)
                    Spacer()
                }
                .padding(.top, Style.listElementPadding)
            }
        }
        .padding(.horizontal, Style.listElementHorizontalPadding)
        .padding(.bottom, Style.listElementPadding)
    }

    var paragraphs: [Paragraph] {
        text
            .components(separatedBy: "\n")
            .map { Paragraph(text: $0) }
    }
}

struct Paragraph: Identifiable {
    let text: String

    var id: String {
        text
    }
}

//struct ParagraphView_Previews: PreviewProvider {
//    static var previews: some View {
//        ParagraphView(
//            text: ModelStubs.akoumBattlesinger.oracleText ?? "",
//            provider: SymbolProviderImpl(fileCache: <#T##FileCache#>, client: StubClient)
//        )
//    }
//}
