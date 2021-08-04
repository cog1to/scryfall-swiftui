//
//  SettingsView.swift
//  Scryfall
//
//  Created by Alexander on 04.08.2021.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: SettingsViewModel

    let presentationStyle: [PresentationStyle] = [.text, .card]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Show as", selection: $settings.presentationStyle) {
                        ForEach(presentationStyle, id: \.self) {
                            Text($0.title)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
