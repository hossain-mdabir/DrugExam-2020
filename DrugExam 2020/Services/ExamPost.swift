//
//  ExamPost.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 4/4/23.
//

import Foundation
import Alamofire


func examPost(post: ExamPostModel, completionHandler: @escaping ((ExamResModel?, Error?)->Void)) {
    
    let encoder = JSONEncoder()
    let jsonData = try! encoder.encode(post)
    
    var request = URLRequest(url: URL(string: ApiString().examPost)!)
    request.httpMethod = HTTPMethod.post.rawValue
    request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData
    
    
    AF.request(request).responseData { response in
        
        print(request.debugDescription)
        print(response.debugDescription)
        
        switch response.result {
        case .success(let value):
            
            let response = try? JSONDecoder().decode(ExamResModel.self, from: value)
            
            print ("Exam POST response: \(response)")
            completionHandler(response, nil)
        case .failure(let error):
            print("Exam POST err: \(error)")
            completionHandler(nil, error)
        }
    }
}
