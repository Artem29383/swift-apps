//
//  Root.swift
//  todolist
//
//  Created by Артем Аверьянов on 05.03.2024.
//

import SwiftUI

struct OnBoardingPreview: View {
    @StateObject private var viewModel = Onboarding()
    @StateObject private var viewModelUser = UserClass()
    @State private var currentPage = 0
    @State private var pageCount = 0
    
    var body: some View {
        NavigationView {
            if let data = viewModel.responseData {
                VStack {
                    Spacer()
                    TabView(selection: $currentPage) {
                        ForEach(data.indices) { index in
                            let slide = data[index]
                            Slide(title: slide.title, description: slide.description, url: slide.getAttributeBuyKey(key: .image))
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 420)
                    .padding(.horizontal, 20)
                    
                    HStack(spacing: 10) {
                        ForEach(0..<pageCount, id: \.self) { index in
                            Circle()
                                .frame(width: 8, height: 8)
                                .foregroundColor(currentPage == index ? .blue : .gray)
                        }
                    }
                    .padding(.vertical, 10)
                    Spacer()
                    NavigationButton(text: "Вход или регистрация", content: Authorization())
                }
            } else {
                Text("Loading...")
                    .onAppear {
                        viewModel.fetchData { data in
                            pageCount = data?.count ?? 0
                        }
                        print("viewModelUser", viewModelUser)
                    }
            }
        }
    }
}

#Preview {
    OnBoardingPreview()
}
