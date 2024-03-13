//
//  QuestionsEdit.swift
//  todolist
//
//  Created by Артем Аверьянов on 13.03.2024.
//

import SwiftUI

struct QuestionsEdit: View {
    var id: Int
    @State private var isOpenEditedTestAlert: Bool = false
    @ObservedObject var testClass = TestClass.shared
    @State private var title: String = ""
    
    private var test: TestModel {
        return testClass.getTestById(id: id)!
    }
    
    init(id: Int) {
        self.id = id
        _title = State(initialValue: test.title)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Дата создания: \(formattedDate(test.created_at))")
                Text("Количество вопросов: \(test.questions.count)")
            }
            
            .navigationTitle(test.title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                isOpenEditedTestAlert.toggle()
            }) {
                Image(systemName: "pencil")
            }, trailing: Button(action: {
                TestClass.shared.removeTest(id: id)
            }) {
                Image(systemName: "trash")
            }
                .foregroundColor(.red)
            )
        }
        .alert("Редактирование", isPresented: $isOpenEditedTestAlert) {
            TextField("Название теста", text: $title)
            Button("Применить", role: .cancel) {
                TestClass.shared.updateTestInfo(id: id, title: title) { data in
//                    title = ""
                }
            }
            Button("Отмена", role: .destructive) { }
        }
    }
}

//#Preview {
//    QuestionsEdit(id: 10)
//}
