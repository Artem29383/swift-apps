//
//  App.swift
//  todolist
//
//  Created by Артем Аверьянов on 06.03.2024.
//

import SwiftUI

struct Main_Application: View {
    var body: some View {
        Navigations()
            .environmentObject(UserClass.shared)
    }
}

#Preview {
    Main_Application()
}
