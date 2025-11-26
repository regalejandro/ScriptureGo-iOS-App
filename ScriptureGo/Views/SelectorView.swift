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
    @State var lastSelected: ChapterPointer = .init(bookID: 0, bookName: "None Chosen", chapter: 0)
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                VStack {
                    VStack(alignment: .leading) {
                        Text("Last Selected")
                            .font(.body)
                            .foregroundColor(.accentColor)
                            .padding()

                        Divider()
                            .padding(.horizontal)
                    }
                    
                    Text(
                        lastSelected.bookID != 0
                        ? "\(lastSelected.bookName) \(lastSelected.chapter)"
                        : "\(lastSelected.bookName)"
                    )
                        .font(.largeTitle)
                        .padding(.top, 24)
                        .padding(.horizontal)

                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 180)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.blue.opacity(0.15))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                )
                .padding()
                

                
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
                
                Spacer()
 
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
            .padding(.top, 50)
        }
        
    }
}

#Preview {
    SelectorView()
}

