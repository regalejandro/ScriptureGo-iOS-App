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
}

