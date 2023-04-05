//
//  UpcomingExam.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 2/4/23.
//

import Foundation

// MARK: - UpcomingExam
struct UpcomingExam: Decodable {
    var message: String?
    var statusCode: Int?
    var objResponse: UpcomingExamData?
}

// MARK: - UpcomingExamData
struct UpcomingExamData: Decodable {
    var examNo: Int?
    var examName: String?
    var examDateTime: String?
    var examDuration: Int?
    var totalQuestion: Int?
    var totalMarks: Int?
    var examStatus: Int?
    var examFlag: Int?
    var remainingTime: String?
    var remaingTimeInMilisec: Float?
}
