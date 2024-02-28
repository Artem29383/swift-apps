//
//  CheckboxToggle.swift
//  todolist
//
//  Created by Артем Аверьянов on 28.02.2024.
//

import Foundation
import SwiftUI


// ckeckbox styling
struct CheckboxToggle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
            
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                
                configuration.label.offset(x: 30)
            }
        }).offset(x: 10)
    }
}
