//
//  MainScreen.swift
//  todolist
//
//  Created by Артем Аверьянов on 07.03.2024.
//

import SwiftUI

//                List {
//                    TestRow(text: "TEST TEST", countOfQuestions: 5)
//                }.listStyle(.grouped)
//                    .scrollContentBackground(.hidden)

struct MainScreen: View {
    @State private var isCreateTestSheetOpen = false
    let isAdmin = UserClass.shared.response?.is_admin ?? false
    @ObservedObject var testClass = TestClass.shared
    
    
    var body: some View {
        NavigationView {
            VStack {
                TestCreate(isAdmin: isAdmin, isCreateTestSheetOpen: $isCreateTestSheetOpen)
                
                if let tests = testClass.tests?.tests {
                    TestsList(tests: tests)
                }
                
                Spacer()
            }
            
            .navigationTitle("Тесты")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                isCreateTestSheetOpen.toggle()
            }, label: {
                Image(systemName: "plus")
            }), trailing: Button(action: {
                UserClass.shared.logout()
            }, label: {
                Text("Выйти")
            }))
        }
        .onAppear {
            TestClass.shared.getTests { data in
                print("DDD", data)
            }
        }
    }
}

#Preview {
    MainScreen()
}
