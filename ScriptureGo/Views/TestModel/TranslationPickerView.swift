//
//  TranslationPickerView.swift
//  ScriptureGo
//
//  Created by Alejandro Regalado on 11/18/25.
//

import SwiftUI

struct TranslationPickerView: View {
    @StateObject var bible = BibleManager()
    @State private var selectedTranslation = "douay-rheims"

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Translation", selection: $selectedTranslation) {
                    Text("Douay-Rheims").tag("douay-rheims")
                    Text("NABRE").tag("nabre")
                }
                .pickerStyle(.segmented)
                .padding()

                List(bible.books(for: selectedTranslation)) { book in
                    NavigationLink(book.name) {
                        BookDetailView(book: book)
                    }
                }
            }
            .navigationTitle("Bible Books")
        }
    }
}


#Preview {
    TranslationPickerView()
}
