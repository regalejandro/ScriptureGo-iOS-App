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
                
                HStack(spacing: 12) {
                    // Main Button
                    Button {
                        if let result = bible.randomChapter(for: selectedTranslation) {
                            lastSelected = result
                        }
                    } label: {
                        Label("Choose Chapter", systemImage: "book")
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(.blue.opacity(0.9))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }

                    // Customization Button
                    Button {

                    } label: {
                        ZStack {
                            Circle()
                                .fill(.ultraThinMaterial)
                                .frame(width: 60, height: 60)

                            Image(systemName: "filemenu.and.selection")
                                .font(.title.bold())
                                .foregroundColor(.blue)
                        }
                    }
                }
                .padding(.horizontal)




                
                
                
                
            }
            .navigationTitle("ScriptureGo")
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
