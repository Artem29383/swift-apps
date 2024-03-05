//
//  UserDefaultsLessonView.swift
//  todolist
//
//  Created by Артем Аверьянов on 02.03.2024.
//

import SwiftUI

struct User: Codable {
    var firstName: String
    var lastName: String
}

func loadUser(user: Binding<User>) {
    let decoder = JSONDecoder()

    do {
        if let userData = UserDefaults.standard.object(forKey: "UserData") as? Data {
            user.wrappedValue = try decoder.decode(User.self, from: userData)
        }
    } catch {
        // Обработка ошибок декодирования
        print("Ошибка декодирования данных пользователя:", error)
    }
}

struct UserDefaultsLessonView: View {
//    User(firstName: "Artem", lastName: "Averyanov")
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    @State private var user = User(firstName: "Artem", lastName: "Averyanov")
    
    
    var body: some View {
        VStack {
            Button("Tap count \(tapCount)") {
                self.tapCount += 1
                UserDefaults.standard.set(self.tapCount, forKey: "Tap")
            }
            
            TextField("FirstName", text: $user.firstName)
            TextField("LastName", text: $user.lastName)

            Button("Save user") {
                let encoder = JSONEncoder()
                
                if let data = try? encoder.encode(self.user) {
                    UserDefaults.standard.set(data, forKey: "UserData")
                }
            }
        }
        .onAppear() {
            loadUser(user: $user)
        }
    }
}

#Preview {
    UserDefaultsLessonView()
}
