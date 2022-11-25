//
//  Router.swift
//  NoteThis
//
//  Created by Jesus Sanz on 25/11/22.
//

import SwiftUI

class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    func reset() {
        path = NavigationPath()
    }
}
