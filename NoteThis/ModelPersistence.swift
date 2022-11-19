//
//  ModelPersistence.swift
//  NoteThis
//
//  Created by Jesus Sanz on 17/11/22.
//

import Foundation

extension URL {
    static let notesDataURL = Bundle.main.url(forResource: "noteDefaultData", withExtension: ".json")!

    static let notesDocsURL = URL.documentsDirectory.appending(component: "NoteThisData").appendingPathExtension("json")
}

final class ModelPersistence {
    
    func loadNotes(url:URL = .notesDataURL) -> [Note] {
        var urlData = URL.notesDocsURL
        if !FileManager.default.fileExists(atPath: urlData.path())
        {
            urlData = url
        }
        do {
            let data = try Data(contentsOf: urlData)
            return try JSONDecoder().decode([Note].self, from: data)
        } catch {
            print("Load error \(error)")
            return []
        }
    }
    
    func saveNotes(notes: [Note]) {
        do {
            let data = try JSONEncoder().encode(notes)
            try data.write(to: .notesDocsURL, options: [.atomic, .completeFileProtection])
        } catch {
            print("Error saving data \(error)")
        }
    }
}