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
    @State var path:[Folder] = []
    
    @State var addFolder = false
    
    var body: some View {
        NavigationStack(path: $path) {
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
            .navigationTitle("Note This")
            .searchable(text: $foldersVM.search)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
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
