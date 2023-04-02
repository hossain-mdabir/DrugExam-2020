//
//  Api.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 2/4/23.
//

import Foundation

class ApiIP: ObservableObject {
    @Published var apiIP: String = "http://192.168.0.29:8088/drug_exam_ws/"
}

class ApiString: ObservableObject {
    @Published var logIn: String = "\(ApiIP().apiIP)api/user/login"
}

