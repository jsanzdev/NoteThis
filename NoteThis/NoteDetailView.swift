//
//  NoteDetailView.swift
//  NoteThis
//
//  Created by Jesus Sanz on 19/11/22.
//

import SwiftUI

struct NoteDetailView: View {
    @EnvironmentObject var foldersVM:FoldersViewModel
    @ObservedObject var detailVM:DetailViewModel
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
                    foldersVM.updateNote(note: detailVM.saveNote(note: note))
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
            NoteDetailView(detailVM: DetailViewModel(note: .noteTest), note: .noteTest)
                .environmentObject(FoldersViewModel())
        }
    }
}
