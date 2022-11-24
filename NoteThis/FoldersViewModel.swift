//
//  FoldersViewModel.swift
//  NoteThis
//
//  Created by Jesus Sanz on 22/11/22.
//

import Foundation

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
    
    
    @Published var ID:Folder.ID
    @Published var name = ""
    @Published var notes:Notes = []
    
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
    
    var filterFolders:[Folder] {
        if search.isEmpty {
            return folders
        } else {
            return folders.filter {
                $0.name.lowercased().hasPrefix(search.lowercased())
            }
        }
    }
    
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
    
    init() {
        self.folders = persistence.loadFolders()
        self.ID = UUID()
    }
    
    func getFolderFromID(id: UUID) -> Folder? {
        folders.first(where: { $0.id == id })
    }
    
    func loadNotes() -> [Note] {
        return self.notes
    }
    
    func saveNotes(notes:Notes, id: UUID) {
        guard let folder = getFolderFromID(id: id) else { return }
        let newFolder = Folder(id: folder.id, name: folder.name, notes: notes)
        updateFolder(folder: newFolder)
    }
    
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
    
    
    func updateFolder(folder:Folder) {
        if let index = folders.firstIndex(where: {$0.id == folder.id }) {
            folders[index] = folder
        }
    }
    
}
