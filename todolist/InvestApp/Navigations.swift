//
//  Navigations.swift
//  todolist
//
//  Created by Артем Аверьянов on 06.03.2024.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        ProgressView() // Используем ProgressView для отображения лоадера
            .progressViewStyle(CircularProgressViewStyle()) // Стиль лоадера (круглый в данном случае)
            .scaleEffect(2) // Увеличиваем размер лоадера
            .padding() // Добавляем отступы
//            .background(Color.black.opacity(0.5)) // Добавляем полупрозрачный фон
            .foregroundColor(Color.white) // Цвет лоадера
            .cornerRadius(10) // Закругляем углы
    }
}

struct Navigations: View {
    @EnvironmentObject var user: UserClass
    
    var body: some View {
        Group {
            if user.isLoading {
                LoaderView()
            }
            else if user.loggedIn {
                MainScreen()
                    .transition(.slide)
            } else {
                OnBoardingPreview()
                    .transition(.slide)
            }
        }
        .animation(.default)
    }
}

#Preview {
    Navigations()
}
