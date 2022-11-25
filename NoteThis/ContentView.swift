//
//  ContentView.swift
//  NoteThis
//
//  Created by Jesus Sanz on 17/11/22.
//

import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var foldersVM:FoldersViewModel
    @State var folderPath:[Folder] = []
    
    @State var addFolder = false
    
    var body: some View {
        NavigationStack(path: $folderPath) {
            List {
                ForEach(foldersVM.orederedFolder) { folder in
                    NavigationLink(value: folder) {
                        FolderCell(folder: folder)
                    }
                }
            }
            .navigationDestination(for: Folder.self) { folder in
                FolderView(folder: folder)
            }
            .navigationTitle("Folders")
            .searchable(text: $foldersVM.search)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Menu("Sort") {
                        ForEach(FoldersViewModel.SortType.allCases, id:\.self) { option in
                            Button {
                                foldersVM.sortType = option
                            } label: {
                                Text(option.rawValue)
                            }
                        }
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        addFolder.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
                
            }
            .sheet(isPresented: $addFolder) {
                FolderSheet()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(FoldersViewModel())
    }
}
