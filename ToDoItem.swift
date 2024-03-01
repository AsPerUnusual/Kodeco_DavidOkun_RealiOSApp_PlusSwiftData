//
//  ToDoItem.swift
//  TodoChecklist
//
//  Created by Ed on 2/29/24.
//

import Foundation
import SwiftData

@Model class ToDoItem: Identifiable {
    
    var id: UUID
    var name: String
    var isComplete: Bool
    
    init( id: UUID = UUID(), name: String = "", isComplete: Bool = false ) {
        
        self.id = id
        self.name = name
        self.isComplete = isComplete
    }

}

func addToDoItem( newName:String ) -> ToDoItem {
    
    return ToDoItem( name: newName, isComplete: false )
}

func generateRandomTodoItem() -> ToDoItem {
    
    let tasks = [ "Laundry", "Dishes", "Exercise", "Take Pictures", "Pay Bills" ]
    let randomIndex = Int.random( in: 0..<tasks.count )
    let randomTask = tasks[ randomIndex ]
    
    return ToDoItem( name: randomTask, isComplete: Bool.random() )
}
