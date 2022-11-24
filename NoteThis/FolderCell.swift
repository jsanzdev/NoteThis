//
//  FolderCell.swift
//  NoteThis
//
//  Created by Jesus Sanz on 22/11/22.
//

import SwiftUI

struct FolderCell: View {
    let folder:Folder
    var body: some View {
        HStack{
            Image(systemName: "folder")
            VStack(alignment: .leading) {
                    Text(folder.name)
                        .font(.headline)
            }
            Spacer()
        }
    }
}


struct FolderCell_Previews: PreviewProvider {
    static var previews: some View {
        FolderCell(folder: .folderTest)
    }
}
