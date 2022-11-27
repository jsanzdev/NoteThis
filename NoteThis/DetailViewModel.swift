//
//  DetailViewModel.swift
//  NoteThis
//
//  Created by Jesus Sanz on 19/11/22.
//

import SwiftUI

final class DetailViewModel:ObservableObject {
    
    @Published var title = ""
    @Published var content = ""
    @Published var date = ""
    
    let note:Note
    
    init(note:Note) {
        self.note = note
        title = note.title
        content = note.content
        date = note.date
    }
    
    func initNote(note:Note) {
        title = note.title
        content = note.content
        date = note.date
    }
    
    func saveNote(note:Note) -> Note {
        Note(id: note.id, title: title, content: content, date: date)
    }
    
    func newNote(title:String, content:String) -> Note {
        Note(id: UUID(), title: title, content: content, date:"2022-01-02 00:00:00")
    }
}
