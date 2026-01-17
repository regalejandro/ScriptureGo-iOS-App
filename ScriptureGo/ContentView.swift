//
//  ContentView.swift
//  ScriptureGo
//
//  Created by Alejandro Regalado on 11/17/25.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
            
        
        TabView {
            
            SelectorView()
                .tabItem {
                    Label("Select", systemImage: "rays")
                }
        
            TranslationPickerView()
                .tabItem {
                    Label("Books", systemImage: "books.vertical.fill")
                }
        }
        .tint(themeManager.current.primary)
        
    }
}

#Preview {
    ContentView()
        .environmentObject(ThemeManager())
}
