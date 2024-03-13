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
    var isRight: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case isRight = "is_right"
    }
}

struct Question: Codable {
    var id: Int
    var title: String
    var questionType: String
    var answer: Int
    var answers: Array<Answer>
    
    enum _CodingKeys: String, CodingKey {
        case id
        case title
        case questionType = "question_type"
        case answer
        case answers
    }
}

struct TestModel: Codable {
    var id: Int
    var createdAt: String
    var title: String
    var questions: Array<Question>
    
    enum __CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case title
        case questions
    }
}


struct TestsModel: Codable {
    var tests: Array<TestModel>
}
