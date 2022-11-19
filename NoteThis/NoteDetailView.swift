//
//  NoteDetailView.swift
//  NoteThis
//
//  Created by Jesus Sanz on 19/11/22.
//

import SwiftUI

struct NoteDetailView: View {
    @EnvironmentObject var noteThisVM:NoteThisViewModel
    @StateObject var detailVM = DetailViewModel()
    @Environment(\.dismiss) var dismiss
    
    let note:Note
    
    var body: some View {
        VStack(alignment: .leading) {
            TextEditor(text: $detailVM.title)
                .lineLimit(1, reservesSpace: true)
                .font(.title)
                .frame(height: 50)
            TextEditor(text: $detailVM.content)
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    noteThisVM.updateNote(note: detailVM.saveNote(note: note))
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
            NoteDetailView(note: .noteTest)
                .environmentObject(NoteThisViewModel())
        }
    }
}
