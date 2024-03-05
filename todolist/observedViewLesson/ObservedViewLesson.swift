//
//  ObservedViewLesson.swift
//  todolist
//
//  Created by Артем Аверьянов on 02.03.2024.
//

import Foundation
import SwiftUI
//
//class User: ObservableObject {
//   @Published var firstName = "Artem"
//   @Published var lastName = "Averyanov"
//}

struct ObservedViewLesson: View {
//    @ObservedObject var user = User()
    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        VStack {
            Text("Your score is \(userSettings.score)")
            Button(action: {
                self.userSettings.score += 1
            }) {
                Text("Increase score")
            }
        }
    }
}

#Preview {
    ObservedViewLesson()
}
