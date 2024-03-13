//
//  Authorization.swift
//  todolist
//
//  Created by Артем Аверьянов on 06.03.2024.
//

import SwiftUI

struct Authorization: View {
    @State private var login = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isLogin = true
    
    var body: some View {
        let isDisabled = isLogin ? login.isEmpty || password.isEmpty : login.isEmpty || password.isEmpty || confirmPassword.isEmpty
        
        NavigationView {
            VStack(alignment: .leading) {
                if (isLogin) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Вход или регистрация")
                            .font(.system(size: 28, weight: .bold))
                        
                        Text("Введите логин и пароль, чтобы войти в приложение")
                            .font(.system(size: 16, weight: .regular))
                            .padding(.bottom, 20)
                        Input(label: "Логин", value: $login, isAutoFocus: true)
                            .textInputAutocapitalization(.never)
                        SecureInput(label: "Пароль", value: $password)
                            .textInputAutocapitalization(.never)
                    }
                    .multilineTextAlignment(.leading)
                } else {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Вход или регистрация")
                            .font(.system(size: 28, weight: .bold))
                        
                        Text("Придумайте логин и пароль, чтобы создать аккаунт")
                            .font(.system(size: 16, weight: .regular))
                            .padding(.bottom, 20)
                        Input(label: "Логин", value: $login, isAutoFocus: true)
                            .textInputAutocapitalization(.never)
                        SecureInput(label: "Пароль", value: $password)
                            .textInputAutocapitalization(.never)
                        SecureInput(label: "Подтвердите пароль", value: $confirmPassword)
                            .textInputAutocapitalization(.never)
                    }
                    .multilineTextAlignment(.leading)
                }
                
                HStack(alignment: .center) {
                    Button(action: {
                        isLogin.toggle()
                    }) {
                        Text(isLogin ? "Создать аккаунт" : "Войти")
                            .foregroundColor(.blue)
                            .multilineTextAlignment(.center)
                    }
                }.frame(maxWidth: .infinity)
                    .padding(.top, 20)
                
                Spacer()
                
                PrimaryButton(text: "Вход", isDisabled: isDisabled, onSubmit: {
                    if isLogin {
                        UserClass.shared.login(login, password)
                    }
                })
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 14)
            .padding(.top, 50)
            
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    Authorization()
}
