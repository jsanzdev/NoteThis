//
//  FoldersViewModel.swift
//  NoteThis
//
//  Created by Jesus Sanz on 22/11/22.
//

import SwiftUI

final class FoldersViewModel:ObservableObject {
    enum SortType: String, CaseIterable {
        case name = "By Name"
        case none = "None"
    }
    
    enum NoteSortType: String, CaseIterable {
        case name = "By Name"
        case date = "By Date"
        case none = "None"
    }
    
    
    @Published var name = ""
    @Published var notes:Notes = [] {
        didSet {
            persistence.saveFolders(folders: folders)
        }
    }
    
    let persistence = ModelPersistence()
    
    @Published var folders:[Folder] {
        didSet {
            persistence.saveFolders(folders: folders)
        }
    }
    @Published var search = ""
    @Published var sortType:SortType = .none
    @Published var noteSortType:NoteSortType = .none
    
    @Published var showDeleteConfirmation = false
    var message = ""
    
    var selectedFolder:Folder?
    var selectedNote:Note?
    
    
    /// Filtering Folders for Searching
    var filterFolders:[Folder] {
        if search.isEmpty {
            return folders
        } else {
            return folders.filter {
                $0.name.lowercased().hasPrefix(search.lowercased())
            }
        }
    }
    
    /// Ordering Folders
    var orederedFolder:[Folder] {
        switch sortType {
        case .name:
            return filterFolders.sorted {
                $0.name < $1.name
            }
        case .none:
            return filterFolders
        }
    }
    
    /// This Filters de Notes for Searching
    var filterNotes:[Note] {
        if search.isEmpty {
            return self.notes
        } else {
            return self.notes.filter {
                $0.title.lowercased().hasPrefix(search.lowercased())
            }
        }
    }
    
    /// This is the order for the notes.
    var orederedNotes:[Note] {
        switch noteSortType {
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
    
    init() {
        self.folders = persistence.loadFolders()
    }
    
    func initFolder(folder: Folder) {
        name = folder.name
        notes = folder.notes
    }
    
    func createFolder(name:String) {
        folders.append(Folder(id: UUID(), name: name, notes: []))
    }
    
    func getFolderFromID(id: UUID) -> Folder? {
        folders.first(where: { $0.id == id })
    }
    
    func loadNotes() -> [Note] {
        return self.notes
    }
    
//    func saveNotes(notes:Notes) {
//        if let index = self.notes.firstIndex(where: {$0.id == notes.id }) {
//            self.notes[index] = notes
//    }
    
    func removeConfirmationFolder(folder:Folder) {
        selectedFolder = folder
        message = "Are you sure you want to delete the folder \(folder.name)? This will delete all the notes inside."
        showDeleteConfirmation.toggle()
    }
    
    func removeNote() {
        guard let selectedFolder else { return }
        folders.removeAll {
            $0.id == selectedFolder.id
        }
        self.selectedFolder = nil
        message = ""
    }
    
    func deleteFolder(indexSet:IndexSet) {
        folders.remove(atOffsets: indexSet)
    }
    
    func deleteNote(indexSet:IndexSet) {
        self.notes.remove(atOffsets: indexSet)
    }
    
    func updateFolder(folder:Folder) {
        if let index = folders.firstIndex(where: {$0.id == folder.id }) {
            folders[index] = folder
        }
    }
    
    func addNote(note:Note) {
        self.notes.append(note)
    }
    
    func updateNote(note:Note) {
        if let index = self.notes.firstIndex(where: {$0.id == note.id }) {
            self.notes[index] = note
        }
    }
    
}
