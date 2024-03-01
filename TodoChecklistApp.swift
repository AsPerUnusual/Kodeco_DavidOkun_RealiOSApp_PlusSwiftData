//
//  TodoChecklistApp.swift
//  TodoChecklist
//
//  Created by Ed on 2/29/24.
//

import SwiftUI

@main
struct TodoChecklistApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer( for: ToDoItem.self )
    }
}
