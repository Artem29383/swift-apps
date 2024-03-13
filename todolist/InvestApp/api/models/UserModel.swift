//
//  UserModel.swift
//  todolist
//
//  Created by Артем Аверьянов on 07.03.2024.
//

import Foundation


struct UserModel: Codable {
    var id: Int
    var username: String
    var is_admin: Bool
}
