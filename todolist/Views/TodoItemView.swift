//
//  TodoItemView.swift
//  todolist
//
//  Created by Артем Аверьянов on 28.02.2024.
//

import Foundation
import SwiftUI

struct TodoItemView: View {
    @Binding var todo: TodoItemCore
    
    var additionalAction: ((_ name: String, _ uuid: UUID) -> Void)?
    
    var body: some View {
        HStack {
            Toggle(isOn: $todo.isActive) {
                Text(todo.name)
            }
            .toggleStyle(CheckboxToggle())
            .contentShape(Rectangle())
            
            Spacer()
            
            if let additionalAction = additionalAction {
                Button(action: {
                    additionalAction(todo.name, todo.id)
                }, label: {
                    Image(systemName: "pencil")
                        .padding(.trailing, 30)
                })
                .buttonStyle(PlainButtonStyle())
            }
        }
        .listRowInsets(EdgeInsets())
    }
}
