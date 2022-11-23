//
//  NoteThisApp.swift
//  NoteThis
//
//  Created by Jesus Sanz on 17/11/22.
//

import SwiftUI

@main
struct NoteThisApp: App {
    @StateObject var foldersVM = FoldersViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(foldersVM)
        }
    }
}
