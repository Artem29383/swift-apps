//
//  AddView.swift
//  todolist
//
//  Created by Артем Аверьянов on 02.03.2024.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @Environment(\.presentationMode) var presentationMode
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Название", text: $name)
                Picker("Тип", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(.navigationLink)
                TextField("Стоимость", text: $amount)
            }
            .navigationBarTitle("Добавить")
            .navigationBarItems(trailing: Button("Сохранить") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: name, type: type, amount: actualAmount)
                    expenses.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
