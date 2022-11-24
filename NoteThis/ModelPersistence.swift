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
    
    func loadFolders(url:URL = .notesDataURL) -> [Folder] {
        let urlData = URL.notesDocsURL
        if !FileManager.default.fileExists(atPath: urlData.path())
        {
            saveFolders(folders: [Folder(id: UUID(), name: "Starter Notes", notes: [Note(id: UUID(), title:"This is the title of the Note", content: "This is the content of the note. As you can see is full of stuff :)", date: "2022-01-02 00:00:00"), Note(id: UUID(), title:"This is the title of the Second Note", content: "This is the content of the second note. As you can see is full of stuff :)", date: "2022-01-03 00:00:00") ])])
        }
        do {
            let data = try Data(contentsOf: urlData)
            return try JSONDecoder().decode([Folder].self, from: data)
        } catch {
            print("Load error \(error)")
            return []
        }
    }
    
    func saveFolders(folders: [Folder]) {
        do {
            let data = try JSONEncoder().encode(folders)
            try data.write(to: .notesDocsURL, options: [.atomic, .completeFileProtection])
        } catch {
            print("Error saving data \(error)")
        }
    }
}
