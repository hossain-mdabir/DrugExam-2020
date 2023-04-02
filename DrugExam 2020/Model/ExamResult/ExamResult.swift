//
//  ExamResult.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 2/4/23.
//

import Foundation

// MARK: - Welcome
struct ExamResult: Decodable {
    var message: String?
    var statusCode: Int?
    var objResponse: ExamResultData?
}

// MARK: - ObjResponse
struct ExamResultData: Decodable {
    var examNo: Int?
    var obtainMarks: Double?
    var grade: String?
    var examname: String?
    var examDate: String?
    var totalmarks: Int?
    var duration: Int?
}
