//
//  ExamPostModel.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 4/4/23.
//

import Foundation

// MARK: - ExamPostModel
struct ExamPostModel: Codable {
    var examNo: Int?
    var gpa: Double?
    var grade: String?
    var mrCode: String?
    var obtainMarks: Double?
    var resultDetails: [ResultDetail]?
}

// MARK: - ResultDetail
struct ResultDetail: Codable {
    var choosenAns: String?
    var examNo: Int?
    var givenAns: String?
    var mrCode: String?
    var quesNo: String?
}
