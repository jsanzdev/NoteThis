//
//  NoteCell.swift
//  NoteThis
//
//  Created by Jesus Sanz on 17/11/22.
//

import SwiftUI

struct NoteCell: View {
    let note:Note
    var body: some View {
        VStack (alignment: .leading) {
            Text(note.title)
                .font(.headline)
            Text(note.content)
        }
    }
}

struct NoteCell_Previews: PreviewProvider {
    static var previews: some View {
        NoteCell(note: .noteTest)
    }
}
