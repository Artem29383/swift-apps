//
//  Input.swift
//  todolist
//
//  Created by Артем Аверьянов on 06.03.2024.
//

import SwiftUI

extension View {
    func placeholder(
        _ text: String,
        when shouldShow: Bool,
        alignment: Alignment = .leading) -> some View {
            
            overlay(
                Group {
                    if shouldShow {
                        HStack {
                            Text(text)
                                .foregroundColor(Color(hex: 0xAAAAAD))
                                .padding(.horizontal, 10)
                                .background(Color.clear)
                            Spacer()
                        }
                    }
                }
            )
        }
}

struct Input: View {
    var label: String
    @Binding var value: String
    var isAutoFocus: Bool?
    @FocusState private var focused: Bool

    var body: some View {
        TextField("", text: $value)
            .padding(10)
            .background(Color(hex: 0xDBDBE0))
            .cornerRadius(12)
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.black)
            .placeholder(label, when: value.isEmpty)
            .focused($focused)
            .onAppear {
                focused = isAutoFocus ?? false
            }
    }
}

struct SecureInput: View {
    var label: String
    @Binding var value: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            SecureField("", text: $value)
                .padding(10)
                .background(Color(hex: 0xDBDBE0))
                .cornerRadius(12)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.black)
            
            if value.isEmpty {
                Text(label)
                    .foregroundColor(Color(hex: 0xAAAAAD))
                    .padding(.horizontal, 10)
                    .font(.system(size: 16, weight: .regular))
                    .allowsHitTesting(false)
            }
        }
    }
}
