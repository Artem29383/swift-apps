//
//  ContentView.swift
//  todolist
//
//  Created by Артем Аверьянов on 26.02.2024.
//

import SwiftUI

struct AlertFactory {
    static func addAlert(todoName: Binding<String>, viewModel: TodosViewModel) -> some View {
        VStack {
            TextField("Название", text: todoName)
                .textInputAutocapitalization(.sentences)
            Button("Добавить", action: {
                viewModel.todos.append(TodoItemCore(name: todoName.wrappedValue))
                todoName.wrappedValue = ""
            })
            Button("Отмена", role: .cancel) {
                todoName.wrappedValue = ""
            }
        }
    }
    
    static func editAlert(todoName: Binding<String>, viewModel: TodosViewModel, editableTodoId: UUID?) -> some View {
        VStack {
            TextField("Название", text: todoName)
                .textInputAutocapitalization(.sentences)
            Button("Изменить", action: {
                if let id = editableTodoId {
                    viewModel.updateTodoName(uuid: id, name: todoName.wrappedValue)
                    todoName.wrappedValue = ""
                }
            })
            Button("Отмена", role: .cancel) {
                todoName.wrappedValue = ""
            }
        }
    }
}

struct ContentView: View {
    @StateObject var viewModel: TodosViewModel = TodosViewModel(todos: [
        TodoItemCore(name: "buy bread"),
        TodoItemCore(name: "clean kitchen", isActive: true),
        TodoItemCore(name: "play games")
    ])
    
    @State private var todoName = ""
    @State private var addAlert = false
    @State private var editAlert = false
    @State private var editableTodoId: UUID?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    ForEach($viewModel.todos) {
                        todoItem in TodoItemView(todo: todoItem) {(name, uuid) in
                            editAlert = true
                            todoName = name
                            editableTodoId = uuid
                        }
                    }
                    .onDelete(perform: handleDelete)
                    .onMove(perform: handleMove)
                    .listRowInsets(nil) // Убираем отступы
                }
                .frame(maxWidth: .infinity)
                .listStyle(InsetListStyle())
                .edgesIgnoringSafeArea(.horizontal)
                .listStyle(.grouped)
                .clipped()
                
                .navigationBarTitle("Todolist", displayMode: .inline)
                .navigationBarItems(
                    leading: Button(action: {
                        viewModel.toggleChecked()
                        viewModel.updateAllTodos()
                    }, label: {
                        Image(systemName: viewModel.isAllChecked ? "checklist.unchecked" : "checklist.checked")
                    }),
                    trailing: Button(action: {
                        addAlert = true
                    }, label: {
                        Image(systemName: "plus")
                    }))
                Spacer()
            }
            .alert("Добавить заметку", isPresented: $addAlert) {
                AlertFactory.addAlert(todoName: $todoName, viewModel: viewModel)
            } message: {
                Text("Введите название заметки")
            }
            .alert("Изменить заметку", isPresented: $editAlert) {
                AlertFactory.editAlert(todoName: $todoName, viewModel: viewModel, editableTodoId: $editableTodoId.wrappedValue)
            } message: {
                Text("Введите название заметки")
            }
        }
    }
    
//    func addAlert() -> Alert {
//        AlertFactory.addAlert(todoName: $todoName, viewModel: viewModel)
//    }
//    
//    func editAlert() -> Alert {
//        return AlertFactory.editAlert(todoName: $todoName, viewModel: viewModel, editableTodoId: editableTodoId!)
//    }
    
    func handleDelete(offsets: IndexSet) {
        viewModel.todos.remove(atOffsets: offsets)
    }
    
    func handleMove(source: IndexSet, destination: Int) {
        viewModel.todos.move(fromOffsets: source, toOffset: destination)
    }
}

#Preview {
    ContentView()
}
