//
//  GuessFlagsView.swift
//  todolist
//
//  Created by Артем Аверьянов on 29.02.2024.
//

import Foundation
import SwiftUI

//func getRandomRange(maxNumber: Int, listSize: Int) -> Set<Int> {
//    var randomNumbers = Set<Int>()
//
//    while randomNumbers.count < listSize {
//        let randomNumber = Int.random(in: 0..<maxNumber)
//        randomNumbers.insert(randomNumber)
//    }
//
//    return randomNumbers
//}

struct GuessFlagsView: View {
    @State private var images = ["argentina", "bangladesh", "brazil", "canada", "germany", "greece", "russia", "sweden", "uk", "usa"].shuffled()
    
    @State private var imagesForRender: [String] = []
    @State private var correctAnswer = Int.random(in: 0..<3)
    @State private var result = 0
    
    private func generate() {
        images = images.shuffled()
        correctAnswer = Int.random(in: 0..<3)
    }
    
    var body: some View {
        VStack {
            Section {
                Text("Выберите флаг: \(images[correctAnswer])")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            }.padding(.top, 70)
            Section {
                VStack {
                    ForEach(Array(images[0 ..< 3]), id: \.self) { name in
                        Image(name).resizable()
                            .scaledToFit()
                            .padding(.horizontal, 70)
                            .onTapGesture {
                                if (name == images[correctAnswer]) {
                                    result += 1
                                } else {
                                    result -= 1
                                }
                                print("tap")
                                generate()
                            }
                    }
                }
                .padding(.top, 50)
                Text("Ваш счёт: \(result)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            }
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [.black, .white]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
//        .onAppear {
//            generate() // Generate initial set of flags when view appears
//        }
    }
}

#Preview {
    GuessFlagsView()
}
