//
//  UserData.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 2/4/23.
//

import Foundation

class UserData: ObservableObject {
    
    var SYSTEM_USER_ID = "areaExecId"
    var USER_CODE = "userCode"
    var USER_NAME = "userName"
    var USER_PASS = "userPass"
    var PARENT_ID = "parentid"
    var MPO_GROUP = "mpoGroup"
    var USER_IS_ACTIVE = "userIsActive"
    var SERVER_APP_VERSION_CODE = "serverAppVersionCode"
    var EXAM_FLAG = "examFlag"
    var APP_VERSION_NAME = "appVersionName"
    var USER_CURRENT_APP_VERSION = "userCurrentAppVersion"
    var USER_ROLE = "userRole"
    var NEED_UPDATE = "needUpdate"
    
    
    // read and write user default
    let userDefault = UserDefaults.standard
    
    
    // write
    func writeAnyData(key: String, value: Any){
        userDefault.set(value, forKey: key)
        userDefault.synchronize()
    }
    
    
    // read int values
    func readIntData(key: String) -> Int{
        if userDefault.object(forKey: key) == nil {
            return 0
        } else {
            return userDefault.integer(forKey: key)
        }
    }
    
    
    // read int values
    func readDoubleData(key: String) -> Double {
        if userDefault.object(forKey: key) == nil {
            return 0.0
        } else {
            return userDefault.double(forKey: key)
        }
    }
    
    
    // read string values
    func readStringData(key: String) -> String{
        if userDefault.object(forKey: key) == nil {
            return ""
        } else {
            return userDefault.string(forKey: key)!
        }
    }
    
    
    // read bool value
    func readBoolData(key: String) -> Bool{
        if userDefault.object(forKey: key) == nil {
            return false
        } else {
            return userDefault.bool(forKey: key)
        }
    }
}
