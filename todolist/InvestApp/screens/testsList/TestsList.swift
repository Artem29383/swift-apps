//
//  TestsList.swift
//  todolist
//
//  Created by Артем Аверьянов on 13.03.2024.
//

import SwiftUI


struct TestRow: View {
    var id: Int
    var text: String
    var countOfQuestions: Int
    
    var body: some View {
        NavigationTapContent(destination: QuestionsEdit(id: id), isHideButtonBack: false) {
            VStack(spacing: 4) {
                HStack() {
                    Text(text)
                        .fontWeight(.bold)
                        .truncationMode(.tail)
                        .lineLimit(2)
                    Spacer()
                }
                HStack {
                    Text("Вопросов: \(countOfQuestions)")
                        .font(.system(size: 14))
                        .foregroundStyle(.secondary)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray, lineWidth: 1))
        }
        .buttonStyle(.plain)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
}

struct TestsList: View {
    var tests: Array<TestModel>
    var body: some View {
        List {
            ForEach(tests, id: \.id) { test in
                TestRow(id: test.id, text: test.title, countOfQuestions: test.questions.count)
            }
        }.listStyle(.grouped)
            .scrollContentBackground(.hidden)
    }
}

#Preview {
    TestsList(tests: [])
}
