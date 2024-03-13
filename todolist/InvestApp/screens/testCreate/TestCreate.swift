//
//  TestCreate.swift
//  todolist
//
//  Created by Артем Аверьянов on 12.03.2024.
//

import SwiftUI

struct TestCreate: View {
    @State private var testTitle = ""
    public var isAdmin: Bool
    @Binding public var isCreateTestSheetOpen: Bool
    
    var body: some View {
        VStack {
            HStack {
                if isAdmin == true {
                    Text("Админ")
                        .foregroundStyle(.green)
                        .fontWeight(.bold)
                }
                Spacer()
            }
            .padding(16)
        }
        .alert("Создайте тест", isPresented: $isCreateTestSheetOpen) {
            TextField("Название теста", text: $testTitle)
            Button("Создать", role: .cancel) {
                TestClass.shared.createTest(title: testTitle) { data in
                    testTitle = ""
                }
            }
            Button("Отмена", role: .destructive) { }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var isCreateTestSheetOpen: Bool = false
    
    static var previews: some View {
        TestCreate(isAdmin: true, isCreateTestSheetOpen: $isCreateTestSheetOpen)
    }
}
