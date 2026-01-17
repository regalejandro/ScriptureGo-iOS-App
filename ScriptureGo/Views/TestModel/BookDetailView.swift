//
//  BookDetailView.swift
//  ScriptureGo
//
//  Created by Alejandro Regalado on 11/18/25.
//

import SwiftUI

struct BookDetailView: View {
    
    @EnvironmentObject var themeManager: ThemeManager
    
    let book: Book

    var body: some View {
        Form {
            Section("Info") {
                HStack {
                    Text("Name")
                        .foregroundColor(themeManager.current.textPrimary)
                    Spacer()
                    Text(book.name)
                        .foregroundColor(themeManager.current.textSecondary)
                }
                
                
                HStack {
                    Text("Chapters")
                        .foregroundColor(themeManager.current.textPrimary)
                    Spacer()
                    Text("\(book.chapters)")
                        .foregroundColor(themeManager.current.textSecondary)

                }
                HStack {
                    Text("Section")
                        .foregroundColor(themeManager.current.textPrimary)
                    Spacer()
                    Text(book.section)
                        .foregroundColor(themeManager.current.textSecondary)

                }
            }

            Section("Groups") {
                ForEach(book.groups, id: \.self) { group in
                    Text(group)
                        .foregroundColor(themeManager.current.textPrimary)

                }
            }
        }
        .navigationTitle(book.name)
    }
}


#Preview {
    BookDetailView(book: Book.init(id: 1, name: "Genesis", chapters: 50, groups: ["A", "B"], section: "Old Testament"))
        .environmentObject(ThemeManager())

}
