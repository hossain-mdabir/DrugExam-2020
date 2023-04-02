//
//  UpcomingExamInfo.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 2/4/23.
//

import Foundation
import Alamofire

class UpcomingExamInfo: ObservableObject {
    @Published var upcomingExamData = UpcomingExamData()
    
    func getUpcomingExamInfo(completionHandler: @escaping ((UpcomingExam?, Error?)->Void)) {
        
        let userCode = UserData().readStringData(key: UserData().USER_CODE)
        let userGroup = UserData().readStringData(key: UserData().MPO_GROUP)
        
        var request = URLRequest(url: URL(string: "\(ApiString().upcomingExam)userCode=\(userCode)&userGroup=\(userGroup)")!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        
        AF.request(request).responseData { response in
            
            print(request.debugDescription)
            print(response.debugDescription)
            
            switch response.result {
            case .success(let value):
                
                let response = try? JSONDecoder().decode(UpcomingExam.self, from: value)
                
                self.upcomingExamData = response?.objResponse ?? UpcomingExamData()
                
                print ("Upcoming Exam response: \(response)")
                completionHandler(response, nil)
            case .failure(let error):
                print("Print Upcoming Exam-\(error)")
                completionHandler(nil, error)
            }
        }
    }
}
