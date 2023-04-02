//
//  LogInPost.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 2/4/23.
//

import Foundation

struct LogInPost: Encodable {
    var androidVersion: Int?
    var appVersionName: String?
    var pkg: String?
    var userCurrentAppVersion: Int?
    var userName: String?
    var userPass: String?
    var userPhone: String?
}

