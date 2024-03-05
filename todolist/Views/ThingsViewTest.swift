//
//  ThingsViewTest.swift
//  todolist
//
//  Created by Артем Аверьянов on 05.03.2024.
//

import SwiftUI

struct ThingsViewTest: View {
    var body: some View {
        VStack {
            Text("1")
            Text("2")
                .offset(y: 15)
                .padding(.bottom, 20)
            Text("3")
        }
    }
}

#Preview {
    ThingsViewTest()
}
