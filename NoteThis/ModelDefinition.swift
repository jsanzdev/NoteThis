//
//  ModelDefinition.swift
//  NoteThis
//
//  Created by Jesus Sanz on 17/11/22.
//

import Foundation

struct Folder: Codable, Identifiable, Hashable {
    let id:UUID
    let name: String
    let notes: [Note]
}

struct Note: Codable, Identifiable, Hashable {
    let id:UUID
    let title: String
    let content:String
    let date:String
}

typealias Folders = [Folder]
typealias Notes = [Note]

extension Folder {
    static let folderTest = Folder(id: UUID(), name: "Starter Notes", notes: [Note(id: UUID(), title:"This is the title of the Note", content: "This is the content of the note. As you can see is full of stuff :)", date: "2022-01-02 00:00:00"), Note(id: UUID(), title:"This is the title of the Second Note", content: "This is the content of the second note. As you can see is full of stuff :)", date: "2022-01-03 00:00:00") ])
}

extension Note {
    static let noteTest = Note(id: UUID(), title:"This is the title of the Note", content: "This is the content of the note. As you can see is full of stuff :)", date: "2022-01-02 00:00:00")
}
