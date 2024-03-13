//
//  QuestionsEdit.swift
//  todolist
//
//  Created by Артем Аверьянов on 13.03.2024.
//

import SwiftUI

struct QuestionsEdit: View {
    var id: Int
    @State private var test: TestModel
    
    init(id: Int) {
        self.id = id
        self._test = State(initialValue: TestClass.shared.getTestById(id: id)!)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Дата создания: \(formattedDate(test.created_at))")
                Text("Количество вопросов: \(test.questions.count)")
            }
            
            .navigationTitle(test.title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                TestClass.shared.removeTest(id: id)
            }) {
                Image(systemName: "trash")
            }
                .foregroundColor(.red)
            )
        }
    }
}

//#Preview {
//    QuestionsEdit(id: 10)
//}
