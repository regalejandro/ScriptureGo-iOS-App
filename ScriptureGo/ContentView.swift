//
//  ContentView.swift
//  ScriptureGo
//
//  Created by Alejandro Regalado on 11/17/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            
        TabView {

            SelectorView()
                .tabItem {
                    Label("Select", systemImage: "rays")
                }

            TranslationPickerView()
                .tabItem {
                    Label("Picker", systemImage: "gearshape")
                }
            
            
        }
    }
}

#Preview {
    ContentView()
}
