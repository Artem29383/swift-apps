//
//  NavigationButton.swift
//  todolist
//
//  Created by Артем Аверьянов on 06.03.2024.
//

import SwiftUI

struct ThemeAnimationStyle: ButtonStyle {
    var isDisabled: Bool = false
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: 58)
            .background(Color(hex: isDisabled ? 0xAAAAAD : 0x4E76FC))
            .cornerRadius(20)
            .padding()
    }
}

struct PrimaryButton: View {
    var text: String
    var isHideButtonBack: Bool = true
    var isDisabled: Bool = false
    var onSubmit: (() -> Void)?
    
    @State private var isPressed = false
    
    var body: some View {
        VStack {
            Button(action: {
                if let onSubmit = onSubmit {
                    onSubmit()
                }
            }) {
                Text(text)
                    .foregroundColor(.white)
            }.buttonStyle(ThemeAnimationStyle(isDisabled: isDisabled))
        }
        .scaleEffect(isPressed ? 0.9 : 1.0)
        .animation(.easeIn, value: isPressed)
        .onLongPressGesture(minimumDuration: .infinity) {
            
        } onPressingChanged: { starting in
            isPressed = starting ? true : false
        }
    }
}

struct NavigationButton<Content: View>: View {
    var text: String
    var content: Content
    var isHideButtonBack: Bool = true
    var isDisabled: Bool = false
    var onSubmit: (() -> Void)?
    
    @State private var isPressed = false
    
    var body: some View {
        VStack {
            NavigationLink(destination: content.navigationBarBackButtonHidden(isHideButtonBack)) {
                Text(text)
                    .foregroundColor(.white)
            }.buttonStyle(ThemeAnimationStyle(isDisabled: isDisabled))
        }
        .scaleEffect(isPressed ? 0.9 : 1.0)
        .animation(.easeIn, value: isPressed)
        .onLongPressGesture(minimumDuration: .infinity) {
            if let onSubmit = onSubmit {
                onSubmit()
            }
            // Do nothing as an action, only the state change matters.
        } onPressingChanged: { starting in
            isPressed = starting ? true : false
        }
    }
}

struct NavigationTapContent<Label, Destination> : View where Label : View, Destination : View {
    var destination: Destination
    var isHideButtonBack: Bool = true
    @ViewBuilder var children: () -> Label
    var isDisabled: Bool = false
    var onSubmit: (() -> Void)?
    @State private var isActive: Bool = false
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            isActive = true
        }) {
            VStack {
                children()
            }
            .contentShape(Rectangle())
        }
        .frame(maxWidth: .infinity)
        .scaleEffect(isPressed ? 0.9 : 1.0)
        .contentShape(Rectangle()) // Установка формы содержимого кнопки
        .animation(.easeIn, value: isPressed)
        .onLongPressGesture(minimumDuration: .infinity) {
            if let onSubmit = onSubmit {
                onSubmit()
            }
            // Do nothing as an action, only the state change matters.
        } onPressingChanged: { starting in
            isPressed = starting ? true : false
        }
        .background(
            NavigationLink(destination: destination.navigationBarBackButtonHidden(isHideButtonBack),
                           isActive: $isActive) {
                               EmptyView()
                           }
                .hidden()
                .buttonStyle(ThemeAnimationStyle(isDisabled: isDisabled))
        )
    }
}

#Preview {
    NavigationButton(text: "Тест", content: Authorization(), onSubmit: {})
}
