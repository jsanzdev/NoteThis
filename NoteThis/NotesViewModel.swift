//
//  NoteThisViewModel.swift
//  NoteThis
//
//  Created by Jesus Sanz on 17/11/22.
//

import SwiftUI

final class NotesViewModel:ObservableObject {
    
    enum SortType: String, CaseIterable {
        case name = "By Name"
        case date = "By Date"
        case none = "None"
    }
    
    @Published var notes:[Note] {
        didSet {
            modelFolder.saveNotes(notes: notes, id: folderID)
        }
    }
    
    @Published var search = ""
    @Published var sortType:SortType = .none
    
    @Published var folderID:UUID
    
    let modelFolder = FoldersViewModel()
    
    @Published var showDeleteConfirmation = false
    var message = ""
    
    var noteToDelete:Note?
    
    var filterNotes:[Note] {
        if search.isEmpty {
            return notes
        } else {
            return notes.filter {
                $0.title.lowercased().hasPrefix(search.lowercased())
            }
        }
    }
    
    init() {
        notes = modelFolder.loadNotes()
        folderID = modelFolder.ID
    }
    
    var orederedNotes:[Note] {
        switch sortType {
        case .name:
            return filterNotes.sorted {
                $0.title < $1.title
            }
        case .date:
            return filterNotes.sorted {
                $0.date > $1.date
            }
        case .none:
            return filterNotes
        }
    }

    func removeConfirmationNote(note:Note) {
        noteToDelete = note
        message = "Are you sure you want to delete the note \(note.title)?"
        showDeleteConfirmation.toggle()
    }
    
    func removeNote() {
        guard let noteToDelete else { return }
        notes.removeAll {
            $0.id == noteToDelete.id
        }
        self.noteToDelete = nil
        message = ""
    }
    
    func deleteNote(indexSet:IndexSet) {
        notes.remove(atOffsets: indexSet)
    }
    
    func updateNote(note:Note) {
        if let index = notes.firstIndex(where: {$0.id == note.id }) {
            notes[index] = note
        }
    }

    
    
}
