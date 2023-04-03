//
//  Question.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 3/4/23.
//

import Foundation

// MARK: - Question
struct Question: Decodable {
    var message: String?
    var statusCode: Int?
    var listResponse: [QuestionInfo]?
}

// MARK: - ListResponse
struct QuestionInfo: Decodable {
    var questionNo: String?
    var questionName: String?
    var choiceA: String?
    var choiceB: String?
    var choiceC: String?
    var choiceD: String?
    var correctAns: String?
    var chosenAns: String?
    var bookmark: Int?
}

