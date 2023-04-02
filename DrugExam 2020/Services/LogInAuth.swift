//
//  LogInAuth.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 2/4/23.
//

import Foundation
import Alamofire


func logInAuth(logIn: LogInPost, completionHandler: @escaping ((LogInRes?, Error?)->Void)) {
    
    let encoder = JSONEncoder()
    let jsonData = try! encoder.encode(logIn)
    
    var request = URLRequest(url: URL(string: ApiString().logIn)!)
    request.httpMethod = HTTPMethod.post.rawValue
    request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData
    
    
    AF.request(request).responseData { response in
        
        print(request.debugDescription)
        print(response.debugDescription)
        
        switch response.result {
        case .success(let value):
//            do {
                let response = try? JSONDecoder().decode(LogInRes.self, from: value)
//            } catch {
//                print("Failed to LogIn")
//            }
            print ("Log In response: \(response)")
            completionHandler(response, nil)
        case .failure(let error):
            print("Print Log In\(error)")
            completionHandler(nil, error)
        }
    }
}
