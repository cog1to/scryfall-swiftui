//
//  SettingsView.swift
//  Scryfall
//
//  Created by Alexander on 04.08.2021.
//

import SwiftUI

struct SettingsView: View {
    let presentationStyle = PresentationStyle.all
    let queryType = QueryType.all
    let sortOrder = SortOrder.all
    let sortDirection = SortDirection.all

    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var settings: SettingsViewModel
    @EnvironmentObject var searchResult: SearchResultsViewModel

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Show", selection: $searchResult.queryType) {
                        ForEach(queryType, id: \.self) {
                            Text($0.title)
                        }
                    }
                    Picker("As", selection: $settings.presentationStyle) {
                        ForEach(presentationStyle, id: \.self) {
                            Text($0.title)
                        }
                    }
                    Picker("Sorted By", selection: $searchResult.sortOrder) {
                        ForEach(sortOrder, id: \.self) {
                            Text($0.title)
                        }
                    }
                    Picker("Direction", selection: $searchResult.sortDirection) {
                        ForEach(sortDirection, id: \.self) {
                            Text($0.title)
                        }
                    }

                }
            }
            .navigationTitle("Settings")
            .navigationBarItems(
                trailing: Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Text("Close")
                }
            )
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
