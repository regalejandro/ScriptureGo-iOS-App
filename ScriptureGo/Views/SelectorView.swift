//
//  SelectorView.swift
//  ScriptureGo
//
//  Created by Alejandro Regalado on 11/20/25.
//

import SwiftUI

struct SelectorView: View {

    
    @AppStorage("selectedTranslation") var selectedTranslation = "Douay-Rheims"
    @AppStorage("selectedGroupsData") private var selectedGroupsData: Data = Data("[]".utf8)
    @AppStorage("groupMode") var groupMode: String = "all"
    
    @StateObject var bible = BibleManager()
    
    @State var translationAtLastSelected = "   "
    @State private var showSettings = false
    @State var lastSelected: ChapterPointer = .init(bookID: 0, bookName: "None Chosen", chapter: 0)
    @State private var showingGroupSelector = false
    @State var selectedGroupsBackup: [String] = []
    
    var selectedGroupsBinding: Binding<[String]> {
        Binding(
            get: {
                (try? JSONDecoder().decode([String].self, from: selectedGroupsData)) ?? []
            },
            set: { newValue in
                if let encoded = try? JSONEncoder().encode(newValue) {
                    selectedGroupsData = encoded
                }
            }
        )
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.sRGB, red: 250/255, green: 235/255, blue: 220/255)
                    .ignoresSafeArea()
                
                VStack {
                    
                    VStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Last Selected")
                                    .font(.body)
                                    .foregroundColor(.accentColor)
                                    .padding()
                                Spacer()
                                
                                Text("\(translationAtLastSelected)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal)
                            }
                            
                            Divider()
                                .padding(.horizontal)
                        }
                        
                        Text(
                            lastSelected.bookID != 0
                            ? "\(lastSelected.bookName) \(lastSelected.chapter)"
                            : "\(lastSelected.bookName)"
                        )
                        .font(.largeTitle)
                        .padding(.top, 22)
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
                            translationAtLastSelected = selectedTranslation
                            
                            if let result = bible.randomChapter(
                                for: selectedTranslation,
                                selectedGroups: selectedGroupsBinding.wrappedValue,
                                groupMode: groupMode
                            ) {
                                lastSelected = result
                            }
                            
                        } label: {
                            Label("Choose Chapter", systemImage: "book")
                                .font(.title2.bold())
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                            
                        }
                        .buttonStyle(.glassProminent)
                        
                        
                        // Customization Button
                        Button {
                            showingGroupSelector = true
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                                .font(.title.bold())
                                .foregroundColor(.blue)
                                .frame(width: 62, height: 62)
                        }
                        .glassEffect(in: Circle())
                        .sheet(isPresented: $showingGroupSelector) {
                            GroupSelectionView(
                                selectedGroups: selectedGroupsBinding,
                                groupMode: $groupMode,
                                selectedGroupsBackup: $selectedGroupsBackup,
                                allGroups: bible.groups(for: selectedTranslation)
                                
                            )
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
                                .padding(6)
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
}

#Preview {
    SelectorView()
}

