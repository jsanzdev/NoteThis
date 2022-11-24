//
//  FolderView.swift
//  NoteThis
//
//  Created by Jesus Sanz on 22/11/22.
//

import SwiftUI
import Combine

struct FolderView: View {
    @EnvironmentObject var foldersVM:FoldersViewModel
    @ObservedObject var notesVM = NotesViewModel()
    @State var notePath:[Note] = []
    
    let folder:Folder
    
    @State var addNote = false
    
    var body: some View {
        NavigationStack(path: $notePath) {
            List {
                ForEach(folder.notes) { note in
                    NavigationLink(value: note) {
                        NoteCell(note: note)
                    }.isDetailLink(false)
                }
            }
            .navigationDestination(for: Note.self) { note in
                NoteDetailView(notesVM: NotesViewModel(), note: note)
            }
            .navigationTitle(folder.name)
            .searchable(text: $notesVM.search)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu("Sort") {
                        ForEach(NotesViewModel.SortType.allCases, id:\.self) { option in
                            Button {
                                notesVM.sortType = option
                            } label: {
                                Text(option.rawValue)
                            }
                        }
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        addNote.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FolderView(folder: .folderTest)
                .environmentObject(FoldersViewModel())
        }
    }
}
