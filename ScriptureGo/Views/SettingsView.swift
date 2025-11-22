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

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Translation")) {

                    ForEach(availableTranslations, id: \.self) { translationID in
                        HStack {
                            Text(translationID)

                            Spacer()

                            // Checkmark for selected translation
                            if translationID == selectedTranslation {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.accentColor)
                            }
                        }
                        .contentShape(Rectangle()) // Makes the whole row tappable
                        .onTapGesture {
                            selectedTranslation = translationID
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}


#Preview {
    SettingsView()
}
