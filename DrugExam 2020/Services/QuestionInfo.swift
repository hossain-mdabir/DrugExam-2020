//
//  QuestionInfo.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 3/4/23.
//

import Foundation
import Alamofire


// MARK: - Question Fetch Structurem ------> \\ Replaced with new method (below)
//func getQuestionInfo() {
//    let userCode = UserData().readStringData(key: UserData().USER_CODE)
//    let userGroup = UserData().readStringData(key: UserData().MPO_GROUP)
//
//    var request = URLRequest(url: URL(string: "\(ApiString().examQes)userCode=\(userCode)&group=\(userGroup)")!)
//    request.httpMethod = HTTPMethod.get.rawValue
//    request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
//
//
//    AF.request(request).responseData { response in
//        print ("Sync : DEBUG DATA-response- :: \(response.debugDescription)")
//        switch response.result {
//        case .success(let value):
//
//            do {
//                let response = try JSONDecoder().decode(Question.self, from: value)
//                print("Question response from DO \(response)")
//
//                let db = QuestionData()
//                let qesInfo = response.listResponse
//                if (qesInfo != nil) {
//                    db.deleteAllQuestion()
//                    for var qes in qesInfo! {
//                        qes.chosenAns = "N"
//                        print("qes-- ::\(qes)")
//                        db.insertQuestion(qes: qes)
//                    }
//                }
//            } catch {
//                print("Question ERROR: \(error)")
//            }
//            print ("Question : DEBUG DATA :: \(value.debugDescription)")
//        case .failure(let error):
//            print("Print Question: \(error)")
//        }
//    }
//}

class QuestionInfos: ObservableObject {
    
    func getQuestionInfo(completionHandler: @escaping ((Question?, Error?)->Void)) {
        
        let userCode = UserData().readStringData(key: UserData().USER_CODE)
        let userGroup = UserData().readStringData(key: UserData().MPO_GROUP)
        
        var request = URLRequest(url: URL(string: "\(ApiString().examQes)userCode=\(userCode)&group=\(userGroup)")!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        AF.request(request).responseData { response in
            
            print(request.debugDescription)
            print(response.debugDescription)
            
            switch response.result {
            case .success(let value):
                
                let response = try? JSONDecoder().decode(Question.self, from: value)
                
                let db = QuestionData()
                let qesInfo = response?.listResponse
                if (qesInfo != nil) {
                    db.deleteAllQuestion()
                    for var qes in qesInfo! {
                        qes.chosenAns = "N"
                        print("qes-- ::\(qes)")
                        db.insertQuestion(qes: qes)
                    }
                }
                
                print("Question response from DO \(response)")
                print ("Question : DEBUG DATA :: \(value.debugDescription)")
                completionHandler(response, nil)
            case .failure(let error):
                print("Print Question: \(error)")
                completionHandler(nil, error)
            }
        }
    }
}
