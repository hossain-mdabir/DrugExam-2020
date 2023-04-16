//
//  ExamResultInfo.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 2/4/23.
//

import Foundation
import Alamofire

class ExamResultInfo: ObservableObject {
    @Published var examResult = ExamResult()
    
    func getExamResult(completionHandler: @escaping ((ExamResult?, Error?)->Void)) {
        
        let userCode = UserData().readStringData(key: UserData().USER_CODE)
        
        var request = URLRequest(url: URL(string: "\(ApiString().examResult)\(userCode)")!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        
        AF.request(request).responseData { response in
            
            print(request.debugDescription)
            print(response.debugDescription)
            
            switch response.result {
            case .success(let value):
                
                let response = try? JSONDecoder().decode(ExamResult.self, from: value)
                
                self.examResult = response ?? ExamResult()
                
                print("Exam Result response: \(response)")
                completionHandler(response, nil)
            case .failure(let error):
                print("Print Exam Result-\(error)")
                completionHandler(nil, error)
            }
        }
    }
}
