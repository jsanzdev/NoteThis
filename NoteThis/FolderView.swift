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
                        addNote.toggle()
                    } label: {
                        Image(systemName: "plus")
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
