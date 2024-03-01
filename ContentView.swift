//
//  ContentView.swift
//  TodoChecklist
//
//  Created by Ed on 2/29/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
   /* @State var todos: [ String ] = [ //immutable error w/o @State, property wrapper, if you have something being updated in the UI you'll probably use @State
        "item 1", "item 2", "item 3", "item 4", "item 5"
    ]*/
    
    @Query var todoList: [ ToDoItem ]
    @Environment( \.modelContext ) private var modelContext
    
    @State var showingAlert: Bool = false
    @State var newItem = ""
    
    func addNewItem() {
        // webinar- todos.append( newItem )
        if newItem != "" {
            modelContext.insert( addToDoItem( newName: newItem ) )
            newItem = "" //clear after adding
        }
    }

    struct LabeledCheckbox: View {
      var labelText: String
      @Binding var isChecked: Bool

      var checkBox: Image {
        Image( systemName: isChecked ? "checkmark" : "circle" )
      }

        var body: some View {
            
            HStack {
                Text( labelText )
                Spacer()
                Button( action: {
                    self.isChecked.toggle()
                }) {
                    checkBox
                }.buttonStyle( BorderlessButtonStyle() ) /* prevents whole item from being a button, not clear why except maybe in a List the whole item is treated as one if a button is involved?  ( hackingwithswift.com forum answer ) */
            }
        }
    }
    
    var body: some View {
 
 /*       ForEach( todos, id: \.self ) { //simple display from array
            todoItem in
            Text( todoItem )
        }*/
        NavigationStack {
           /* webinar: List( $todos, id: \.self, editActions: .all ) { //$ on todos, todoItem adding editActions allow re-arranging and delete
                $todoItem in
                Text( todoItem )
            }.navigationTitle( "Todo List" ) //used by NavigationStack
                .toolbar {
                    ToolbarItem( placement: .primaryAction ) {
                        Button {
                            showingAlert = true
                        } label: {
                            Text( "new item" )
                            Image( systemName: "plus" )
                        }
                    }
                }
            end webinar code */
            List {
                ForEach( todoList ) { todoItem in
                    let isCheckedBinding = Binding<Bool>(get: { todoItem.isComplete }, set: { if $0 { todoItem.isComplete = true } else { todoItem.isComplete = false }} )
                    LabeledCheckbox( labelText: todoItem.name, isChecked: isCheckedBinding )
                }.onDelete( perform: {
                    indexSet in
                    for index in indexSet {
                        let itemToDelete = todoList[ index ]
                        modelContext.delete( itemToDelete )
                    }
                })
            }.navigationTitle( "Todo List" ) //used by NavigationStack
                .toolbar {
                    ToolbarItem( placement: .primaryAction ) {
                        Button {
                            showingAlert = true
                        } label: {
                            Text( "new item" )
                            Image( systemName: "plus" )
                        }
                    }
                }
        }.alert( "What's your new item?", isPresented: $showingAlert) {
            TextField( "Add item here", text: $newItem )
            Button {
                addNewItem()
            } label: {
                Text( "Ok" )
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer( for: ToDoItem.self )
}
