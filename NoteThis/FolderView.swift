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
    @EnvironmentObject var router: Router
    
    let folder:Folder
    
    @State var addNote = false
    
    var body: some View {
        List(foldersVM.notes) { note in
            NavigationLink(value: note) {
                NoteCell(note: note)
            }
        }
        .navigationTitle($foldersVM.name)
        .searchable(text: $foldersVM.search)
        .navigationDestination(for: Note.self) { note in
            NoteDetailView(detailVM: DetailViewModel(note: note), note: note)
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Menu("Sort") {
                    ForEach(FoldersViewModel.NoteSortType.allCases, id:\.self) { option in
                        Button {
                            foldersVM.noteSortType = option
                        } label: {
                            Text(option.rawValue)
                        }
                    }
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    let newNote = Note(id: UUID(), title: "", content: "", date: "")
                    router.path.append(newNote)
                    //NoteDetailView(detailVM: DetailViewModel(note: newNote), note: newNote)
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .onAppear {
            foldersVM.initFolder(folder: folder)
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
