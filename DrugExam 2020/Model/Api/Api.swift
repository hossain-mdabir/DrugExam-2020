//
//  Api.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 2/4/23.
//

import Foundation

class ApiIP: ObservableObject {
    @Published var apiIP: String = "http://192.168.0.29:8088/drug_exam_ws/api/" // Local
}

class ApiString: ObservableObject {
    @Published var logIn: String = "\(ApiIP().apiIP)user/login"
    @Published var upcomingExam: String = "\(ApiIP().apiIP)exam/get-upcoming-exam-status?"
    @Published var examResult: String = "\(ApiIP().apiIP)exam/get-last-personal-result/"
    @Published var examQes: String = "\(ApiIP().apiIP)exam/get-exam-ques/?"
}

