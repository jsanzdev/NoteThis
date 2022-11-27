//
//  FolderSheet.swift
//  NoteThis
//
//  Created by Jesus Sanz on 23/11/22.
//

import SwiftUI
import Combine

struct FolderSheet: View {
    @EnvironmentObject var foldersVM:FoldersViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var newFolderName = ""
    
    var body: some View {
        Group {
            TextField("Folder Name..", text: $newFolderName)
                .textFieldStyle(.roundedBorder)
                .padding()
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
            }
            ToolbarItem {
                Text("New Folder")
                    .font(.headline)
            }
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    foldersVM.createFolder(name: newFolderName)
                    dismiss()
                } label: {
                    Text("OK")
                }
            }
        }
        
    }
}

struct FolderSheet_Previews: PreviewProvider {
    static var previews: some View {
        FolderSheet()
            .environmentObject(FoldersViewModel())
    }
}
