//
//  Slide.swift
//  todolist
//
//  Created by Артем Аверьянов on 05.03.2024.
//

import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double((hex >> 0) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct ImageView: View {
    var url: String
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 260, height: 236)
            } else if phase.error != nil {
                // Обработка ошибки загрузки изображения
                Text("Failed to load image")
            } else {
                // Показываем заглушку во время загрузки изображения
                ProgressView()
            }
        }
    }
}

struct Slide: View {
    var title: String = "Бесплатное открытие брокерского счета"
    var description: String = "Получите индивидуальные инвестиционные рекомендации по вашему портфелю, составленные инвесторами"
    var url: String = "https://storage.yandexcloud.net/gpbi-lk-static-files-alpha/banners/1_1.png"
    
    var body: some View {
        VStack {
            VStack {
                ImageView(url: url)
                VStack(spacing: 20) {
                    Text(title)
                        .font(.system(size: 28, weight: .bold))
                        .multilineTextAlignment(.center)
                    Text(description)
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(hex: 0x767679))
                        .lineLimit(3)
                }
            }
        }
    }
}

#Preview {
    Slide()
}
