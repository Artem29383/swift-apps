//
//  NavigationViewLesson.swift
//  todolist
//
//  Created by Артем Аверьянов on 02.03.2024.
//

import SwiftUI

//struct DetailView: View {
//    var body: some View {
//        Text("This is the detail view")
//    }
//}
//
//struct NavigationViewLesson: View {
//    var body: some View {
//        NavigationView {
//            VStack {
//                NavigationLink(destination: DetailView()) {
//                    Text("Go to the DetailView")
//                }
//                
//                .navigationBarTitle("Navigation", displayMode: .inline)
//            }
//        }
//    }
//}

struct Cat: Identifiable {
    var id = UUID()
    var name: String
    var weight: Double
    var kind: String
}

struct CatRow: View {
    var cat: Cat
    
    var body: some View {
        Text(cat.name)
            .font(.title)
    }
}

struct DetailCatView: View {
    var cat: Cat

    var body: some View {
        VStack {
            Text("Имя: \(cat.name)")
            Text("Вес: \(cat.weight, specifier: "%.1f") кг")
            Text("Тип: \(cat.kind)")
        }
    }
}

struct NavigationViewLesson: View {
    var body: some View {
        let cat = Cat(name: "Цири", weight: 2.9, kind: "Абиссинская")
        let cat2 = Cat(name: "Марс", weight: 5.0, kind: "Британец")
        let cat3 = Cat(name: "Проша", weight: 6.0, kind: "Британец")
        let cats = [cat, cat2, cat3]
        
        NavigationView {
            List(cats) { cat in
                NavigationLink(destination: DetailCatView(cat: cat)) {
                    CatRow(cat: cat)
                }
            }
            
            .navigationTitle("NavigationView")
        }
    }
}

#Preview {
    NavigationViewLesson()
}
