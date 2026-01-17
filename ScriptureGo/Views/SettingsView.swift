//
//  SettingsView.swift
//  ScriptureGo
//
//  Created by Alejandro Regalado on 11/21/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedTradition") var selectedTradition = "Catholic"
    @AppStorage("selectedTranslation") var selectedTranslation = "Douay-Rheims"
    @AppStorage("selectedTheme") var selectedTheme = "parchment"
    @StateObject var bible = BibleManager()

    @EnvironmentObject var themeManager: ThemeManager
    
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
                    /* Tradition */
                    Section(header: Text("Tradtion")) {
                        ForEach(["Catholic", "Orthodox", "Protestant"], id: \.self) { tradition in
                            HStack{
                                Text(tradition)
                                Spacer()
                                if tradition == selectedTradition {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(themeManager.current.accent)
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedTradition = tradition
                            }
                        }
                        
                    }
                    .foregroundColor(themeManager.current.textPrimary)

                    
                    /* Translations */
                    if let translations = categorizedTranslations[selectedTradition], !translations.isEmpty {
                        Section(header: Text("\(selectedTradition) Translations")) {
                            ForEach(translations, id: \.self) { translationID in
                                HStack {
                                    Text(translationID)
                                    Spacer()
                                    if translationID == selectedTranslation {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(themeManager.current.accent)
                                    }
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    selectedTranslation = translationID
                                }
                            }
                        }
                        .foregroundColor(themeManager.current.textPrimary)

                    }
                    
                    
                    Section(header: Text("App Theme")) {
                        // Parchment
                        HStack {
                            Text("Parchment")
                            Spacer()
                            if selectedTheme == "parchment" {
                                Image(systemName: "checkmark")
                                    .foregroundColor(themeManager.current.accent)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedTheme = "parchment"
                            withAnimation(.easeInOut(duration: 0.25)) {
                                themeManager.setTheme(.parchment)
                            }
                        }
                        
                        // Meadow
                        HStack {
                            Text("Meadow")
                            Spacer()
                            if selectedTheme == "meadow" {
                                Image(systemName: "checkmark")
                                    .foregroundColor(themeManager.current.accent)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedTheme = "meadow"
                            withAnimation(.easeInOut(duration: 0.25)) {
                                themeManager.setTheme(.meadow)
                            }
                        }
                    }
                    .foregroundColor(themeManager.current.textPrimary)

                
                }
                .navigationTitle("Settings")
            }

        }
    }
}


#Preview {
    SettingsView()
        .environmentObject(ThemeManager())

}
