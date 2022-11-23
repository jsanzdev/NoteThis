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
    
    var body: some View {
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                     Text("Canel")
                    }
                    Text("New Folder")
                        .font(.headline)
                    Button {
                        // We call the function to add the folder
                    } label: {
                     Text("OK")
                    }
                }
                
                TextField("Folder Name..", text: $foldersVM.name)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu("Sort") {
                        ForEach(NotesViewModel.SortType.allCases, id:\.self) { option in
                            Button {
                                
                            } label: {
                                Text("Cancel")
                            }
                        }
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        
                    } label: {
                        Text("Add")
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
