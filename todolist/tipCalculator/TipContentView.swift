//
//  TipContentView.swift
//  todolist
//
//  Created by Артем Аверьянов on 28.02.2024.
//

import Foundation
import SwiftUI

struct TipContentView: View {
    @State private var amount = ""
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 0
    
    private let tipPercentages = [0, 5, 10, 15, 20, 25]
    
    var tipAmount: Double {
        if let amountDouble = Double(amount) {
            let doubleNumberOfPeople = Double(numberOfPeople + 2)
            let tipPercent = Double(tipPercentages[tipPercentage])
            
            let moneyForFood = amountDouble / doubleNumberOfPeople
            
            let tip = moneyForFood / 100.0 * tipPercent
            
            return tip
        }
        
        return 0
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Общий счет", text: $amount)
                        .keyboardType(.numberPad)
                        .onChange(of: amount) { oldValue, newValue in
                            amount = newValue.filter { $0.isNumber }
                        }
                    Picker("Количество людей", selection: $numberOfPeople) {
                        ForEach(0..<101) {
                            Text("\($0 + 2) человек")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section(header: Text("Сколько чаевых вы хотите оставить?")) {
                    Picker("", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(.palette)
                }
                
                Section(header: Text("Вы должны оставить чаевых")) {
                    Text("\(tipAmount, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("Калькулятор чаевых", displayMode: .inline)
        }
    }
}

#Preview {
    TipContentView()
}
