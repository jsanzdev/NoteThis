//
//  ContentView.swift
//  NoteThis
//
//  Created by Jesus Sanz on 17/11/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var noteThisVM:NoteThisViewModel
    @State var path:[Note] = []
    
    @State var addNote = false
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(noteThisVM.orederedNotes) { note in
                    NavigationLink(value: note) {
                        NoteCell(note: note)
                    }
                }
            }
            .navigationDestination(for: Note.self) { note in
                NoteDetailView(note: note)
            }
            .navigationTitle("Note This")
            .searchable(text: $noteThisVM.search)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu("Sort") {
                        ForEach(NoteThisViewModel.SortType.allCases, id:\.self) { option in
                            Button {
                                noteThisVM.sortType = option
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(NoteThisViewModel())
    }
}
