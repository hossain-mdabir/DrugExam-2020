//
//  LogInRes.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 2/4/23.
//

import Foundation

// MARK: - Welcome
struct LogInRes: Decodable {
    var message: String?
    var statusCode: Int?
    var objResponse: UserDataRes?
}

// MARK: - ObjResponse
struct UserDataRes: Decodable {
    var systemUserid: String?
    var userCode: String?
    var userName: String?
    var userPass: String?
    var parentId: String?
    var mpoGroup: String?
    var userIsActive: Int?
    var serverAppVersionCode: Int?
    var examFlag: Int?
    var appVersionName: String?
    var userCurrentAppVersion: Int?
    var userRole: String?
    var needUpdate: Int?
}
