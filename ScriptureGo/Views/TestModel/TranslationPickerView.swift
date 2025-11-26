//
//  TranslationPickerView.swift
//  ScriptureGo
//
//  Created by Alejandro Regalado on 11/18/25.
//

import SwiftUI

struct TranslationPickerView: View {
    @AppStorage("selectedTranslation") var selectedTranslation = "Douay-Rheims"
    @StateObject var bible = BibleManager()
    

    var body: some View {
        NavigationStack {
            VStack {
                /*
                Picker("Translation", selection: $selectedTranslation) {
                    Text("Douay-Rheims").tag("Douay-Rheims")
                    Text("NABRE").tag("NABRE")
                }
                .pickerStyle(.segmented)
                .padding()*/

                List(bible.books(for: selectedTranslation)) { book in
                    NavigationLink(book.name) {
                        BookDetailView(book: book)
                    }
                }
            }
            .navigationTitle("Books")
        }
    }
}


#Preview {
    TranslationPickerView()
}
