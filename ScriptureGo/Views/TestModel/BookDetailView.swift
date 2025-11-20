//
//  BookDetailView.swift
//  ScriptureGo
//
//  Created by Alejandro Regalado on 11/18/25.
//

import SwiftUI

struct BookDetailView: View {
    let book: Book

    var body: some View {
        Form {
            Section("Info") {
                HStack {
                    Text("Name")
                    Spacer()
                    Text(book.name)
                }
                HStack {
                    Text("Chapters")
                    Spacer()
                    Text("\(book.chapters)")
                }
                HStack {
                    Text("Section")
                    Spacer()
                    Text(book.section)
                }
            }

            Section("Groups") {
                ForEach(book.groups, id: \.self) { group in
                    Text(group)
                }
            }
        }
        .navigationTitle(book.name)
    }
}


#Preview {
    BookDetailView(book: Book.init(id: 1, name: "Genesis", chapters: 50, groups: ["A", "B"], section: "Old Testament"))
}
