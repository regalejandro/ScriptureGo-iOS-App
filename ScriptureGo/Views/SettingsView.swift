//
//  SettingsView.swift
//  ScriptureGo
//
//  Created by Alejandro Regalado on 11/21/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedTranslation") var selectedTranslation = "Douay-Rheims"
    @StateObject var bible = BibleManager()

    var availableTranslations: [String] {
        bible.data?.translations.keys.sorted() ?? []
    }
    
    var categorizedTranslations: [String: [String]] {
        let all = bible.data?.translations.keys.sorted() ?? []

        return Dictionary(
            grouping: all,
            by: { bible.tradition(of: $0) }
        )
    }


    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(["Catholic", "Orthodox", "Protestant", "Other"], id: \.self) { category in
                        if let translations = categorizedTranslations[category], !translations.isEmpty {
                            Section(header: Text(category)) {
                                ForEach(translations, id: \.self) { translationID in
                                    HStack {
                                        Text(translationID)
                                        Spacer()
                                        if translationID == selectedTranslation {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.accentColor)
                                        }
                                    }
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        selectedTranslation = translationID
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Settings")
            }

        }
    }
}


#Preview {
    SettingsView()
}
