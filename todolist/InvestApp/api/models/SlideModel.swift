//
//  SlideModel.swift
//  todolist
//
//  Created by Артем Аверьянов on 05.03.2024.
//

import Foundation

enum AttributeKeys: String, Codable {
    case buttonTitle = "buttonTitle"
    case viewingTime = "viewingTime"
    case image = "image"
}

struct Attribute: Codable {
    var key: AttributeKeys
    var value: String
}

struct SlideModel: Codable, Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var attributes: [Attribute]
    
    func getAttributeBuyKey(key: AttributeKeys) -> String {
        return attributes.first(where: { $0.key == key })!.value
    }
}
