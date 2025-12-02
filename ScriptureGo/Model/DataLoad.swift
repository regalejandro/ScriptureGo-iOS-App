//
//  DataLoad.swift
//  ScriptureGo
//
//  Created by Alejandro Regalado on 11/18/25.
//

import Foundation
import Combine

class BibleManager: ObservableObject {
    @Published var data: BibleData?

    init() {
        load()
    }

    func load() {
        guard let url = Bundle.main.url(forResource: "booknames", withExtension: "json") else {
            print("JSON not found")
            return
        }

        do {
            let jsonData = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(BibleData.self, from: jsonData)
            self.data = decoded
        } catch {
            print("Error loading JSON:", error)
        }
    }

    func books(for translation: String) -> [Book] {
        data?.translations[translation]?.books ?? []
    }
    
    func randomChapter(for translation: String) -> ChapterPointer? {
        guard let books = data?.translations[translation]?.books else { return nil }
        
        // Total chapters across all books
        let totalChapters = books.reduce(0) { $0 + $1.chapters }
        guard totalChapters > 0 else { return nil }

        // Choose a chapter index across the entire canon
        let randomIndex = Int.random(in: 1...totalChapters)

        // Find which book that chapter index belongs to
        var runningTotal = 0

        for book in books {
            let nextTotal = runningTotal + book.chapters
            if randomIndex <= nextTotal {
                let chapterNumber = randomIndex - runningTotal
                return ChapterPointer(bookID: book.id, bookName: book.name, chapter: chapterNumber)
            }
            runningTotal = nextTotal
        }

        return nil
    }


    
}

