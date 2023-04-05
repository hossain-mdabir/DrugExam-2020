//
//  ExamRes.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 4/4/23.
//

import Foundation

// MARK: - Welcome
struct ExamResModel: Decodable {
    var message: String?
    var statusCode: Int?
    var objResponse: ResultInfo?
}

// MARK: - ObjResponse
struct ResultInfo: Decodable {
    var resultId: Int?
    var examNo: Int?
    var mrCode: String?
    var obtainMarks: Double?
    var gpa: Double?
    var grade: String?
//    var resultDetails: [Any?]?
}
