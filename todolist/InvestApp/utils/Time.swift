//
//  Time.swift
//  todolist
//
//  Created by Артем Аверьянов on 13.03.2024.
//

import Foundation

func formattedDate(_ data: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    
    guard let date = dateFormatter.date(from: data) else {
        return "Invalid Date Format"
    }

    dateFormatter.dateFormat = "yyyy-MM-dd"
    let resultString = dateFormatter.string(from: date)

    return resultString
}
