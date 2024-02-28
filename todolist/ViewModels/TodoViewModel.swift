//
//  TodoViewModel.swift
//  todolist
//
//  Created by Артем Аверьянов on 28.02.2024.
//

import Foundation


struct TodoItemCore: Identifiable {
    let id = UUID()
    var name: String
    var isActive: Bool = false
}

class TodosViewModel: ObservableObject {
    var isAllChecked = false
    
    @Published var todos: [TodoItemCore] {
        didSet {
            isAllChecked = todos.allSatisfy({ $0.isActive })
        }
    }
    
    init(todos: [TodoItemCore]) {
        self.todos = todos
    }
    
    func updateAllTodos() {
        todos = todos.map { todo in
            var updatedTodo = todo
            updatedTodo.isActive = isAllChecked
            return updatedTodo
        }
    }
    
    func updateTodoName(uuid: UUID, name: String) {
        //        todos = todos.map { todo in
        //            var updatedTodo = todo
        //            if (updatedTodo.id == uuid) {
        //                updatedTodo.name = name
        //            }
        //
        //            return updatedTodo
        //        }
        
        if let index = todos.firstIndex(where: { $0.id == uuid}) {
            todos[index].name = name
        }
    }
    
    func toggleChecked() {
        isAllChecked = !isAllChecked
    }
}
