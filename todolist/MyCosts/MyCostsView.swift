//
//  MyCostsView.swift
//  todolist
//
//  Created by Артем Аверьянов on 02.03.2024.
//

import SwiftUI

struct MyTypeOfCosts: View {
    var type: Binding<String>
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        List {
            ForEach(types, id: \.self) { typeName in
                Button(action: {
                    type.wrappedValue = typeName
                }, label: {
                    HStack {
                        Text(typeName)
                        Spacer()
                        Image(systemName: type.wrappedValue == typeName ? "checkmark" : "")
                    }
                })
            }
//            Button(action: {
//                type.wrappedValue = "Personal"
//            }, label: {
//                HStack {
//                    Text("Personal")
//                    Spacer()
//                    Image(systemName: type.wrappedValue == "Personal" ? "checkmark" : "")
//                }
//            })
        }.listStyle(.grouped)
    }
}

struct MyListItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var type: String
    var cost: String
}

class ItemsViewModel: ObservableObject {
    @Published var items: [MyListItem]
    
    init(items: [MyListItem]) {
        self.items = []
    }
    
    func loadList() {
        let decoder = JSONDecoder()

        do {
            if let userData = UserDefaults.standard.object(forKey: "List") as? Data {
                items = try decoder.decode([MyListItem].self, from: userData)
            }
        } catch {
            // Обработка ошибок декодирования
            print("Ошибка декодирования данных пользователя:", error)
        }
    }
    
    func appendItemToList(item: MyListItem) {
        items.append(item)
        
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(items) {
            UserDefaults.standard.set(data, forKey: "List")
        }
    }
    
    func removeItemFromList(offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(items) {
            UserDefaults.standard.set(data, forKey: "List")
        }
    }
}

struct MySheetItem: View {
    @State private var name = ""
    @State private var cost = ""
    @State private var type = "Personal"
    var onSubmit: (MyListItem) -> Void
    var onClose: () -> Void
    
    var body: some View {
        NavigationView {
            List {
                TextField("Название", text: $name)
                NavigationLink(destination: MyTypeOfCosts(type: $type), label: {
                    HStack {
                        Text("Тип")
                        Spacer()
                        Text(type)
                    }
                })
                TextField("Стоимость", text: $cost)
                    .keyboardType(.numberPad)
                    .onChange(of: cost) { oldValue, newValue in
                        cost = newValue.filter { $0.isNumber }
                    }
            }.listStyle(.grouped)
            
                .navigationBarTitle("Добавить")
                .navigationBarItems(
                    trailing: Button(action: {
                        onSubmit(MyListItem(name: name, type: type, cost: cost))
                        onClose()
                    }, label: {
                        Text("Сохранить")
                    })
                    .disabled(name == "" || cost == "")
                )
        }
    }
}


struct ItemRow: View {
    var item: MyListItem
    
    var body: some View {
        HStack {
            VStack {
                Text("\(item.name)")
                Text("\(item.type)")
            }
            Text("\(item.cost)")
        }
    }
}

struct MyCostsView: View {
    @State private var isSheetOpen = false
    @StateObject private var itemsViewModel = ItemsViewModel(items: [])
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(itemsViewModel.items) { item in
                    ItemRow(item: item)
                }.onDelete(perform: itemsViewModel.removeItemFromList)
            }.listStyle(.grouped)
            
                .navigationBarTitle("Мои расходы", displayMode: .inline)
                .navigationBarItems(
                    trailing: Button(action: {
                        isSheetOpen.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    }))
                .sheet(isPresented: $isSheetOpen, content: {
                    MySheetItem(onSubmit: itemsViewModel.appendItemToList, onClose: {
                        isSheetOpen.toggle()
                    })
                })
                .onAppear() {
                    itemsViewModel.loadList()
                }
        }
    }
}

#Preview {
    MyCostsView()
}
