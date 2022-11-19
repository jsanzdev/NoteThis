//
//  ModelDefinition.swift
//  NoteThis
//
//  Created by Jesus Sanz on 17/11/22.
//

import Foundation

struct Note: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let content:String
    let date:String
}

typealias Notes = [Note]

extension Note {
    static let noteTest = Note(id: 1, title:"This is the title of the Note", content: "This is the content of the note. As you can see is full of stuff :)", date: "2022-01-02 00:00:00")
}
