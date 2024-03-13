//
//  TestsModel.swift
//  todolist
//
//  Created by Артем Аверьянов on 12.03.2024.
//

import Foundation

struct Answer: Codable {
    var id: Int
    var text: String
    var is_right: Bool
}

struct Question: Codable {
    var id: Int
    var title: String
    var question_type: String
    var answer: Int
    var answers: Array<Answer>
}

struct TestModel: Codable {
    var id: Int
    var created_at: String
    var title: String
    var questions: Array<Question>
}


struct TestsModel: Codable {
    var tests: Array<TestModel>
}
