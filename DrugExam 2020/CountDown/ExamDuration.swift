//
//  ExamDuration.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 15/4/23.
//

import Foundation


class ExamDuration: ObservableObject {
    @Published var counter: Int64 = 0
    @Published var timeRead: String = ""
    
    //    init(counter: Int64) {
    //        self.counter = counter
    //        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    //    }
    
    @objc func updateCounter(counter: Int64) {
        self.counter = counter
        //        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        //example functionality
        if self.counter > 0 {
            print("\(self.counter) seconds to the end of the world (Duration)")
            self.counter -= 1
            convertRedableTime2(sec: self.counter)
        }
    }
    
    
    func convertRedableTime(sec: Int64) {
        if(sec > 0) {
            let remSec = sec % 60
            let m = (sec - remSec) / 60
            
            let remMin = m % 60
            let h = (m - remMin) / 60
            
            let remHour = h % 24
            let d = (h - remHour) / 24
            
            timeRead = "D: \(d) H: \(h) M: \(m) S:\(remSec)"
            print("timeRead-method \(timeRead)")
        }
    }
    func convertRedableTime2(sec: Int64) {
        if(sec > 0){
            
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.day, .hour, .minute, .second]
            formatter.unitsStyle = .abbreviated
            
            let formattedString = formatter.string(from: TimeInterval(sec))!
            timeRead = formattedString
            print("timeRead-method \(formattedString)")
        }
    }
}
