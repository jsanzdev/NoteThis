//
//  NoteDetailView.swift
//  NoteThis
//
//  Created by Jesus Sanz on 19/11/22.
//

import SwiftUI

struct NoteDetailView: View {
    @EnvironmentObject var foldersVM:FoldersViewModel
    @ObservedObject var notesVM:NotesViewModel
    @StateObject var detailVM = DetailViewModel()
    @Environment(\.dismiss) var dismiss
    
    let note:Note
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("This is the title", text: $detailVM.title, axis: .vertical)
                .font(.title)
            TextEditor(text: $detailVM.content)
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    notesVM.updateNote(note: detailVM.saveNote(note: note))
                    dismiss()
                } label: {
                    Text("Save")
                }
            }
        }
        .padding()
        .onAppear {
            detailVM.initNote(note: note)
        }
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NoteDetailView(notesVM: NotesViewModel(), note: .noteTest)
                .environmentObject(FoldersViewModel())
        }
    }
}
