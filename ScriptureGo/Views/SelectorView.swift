//
//  SelectorView.swift
//  ScriptureGo
//
//  Created by Alejandro Regalado on 11/20/25.
//

import SwiftUI

struct SelectorView: View {
    
    @AppStorage("selectedTranslation") var selectedTranslation = "Douay-Rheims"
    @StateObject var bible = BibleManager()
    
    @State private var showSettings = false
    @State var lastSelected: ChapterPointer = .init(bookID: 0, bookName: "None Selected", chapter: 0)
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                if lastSelected.bookID != 0 {
                    Text("\(lastSelected.bookName) \(lastSelected.chapter)")
                        .font(.largeTitle)
                        .padding()
                }
                
                Button {
                    if let result = bible.randomChapter(for: selectedTranslation) {
                        lastSelected = result
                    }
                } label: {
                    Label("Choose Chapter", systemImage: "book.circle.fill")
                }
                .padding()
                
                
            }
            .navigationTitle("Selector")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gear")
                            .font(.system(size: 18, weight: .semibold))
                            .padding(12)
                            .clipShape(Circle())

                        
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
        }
        
    }
}

#Preview {
    SelectorView()
}
