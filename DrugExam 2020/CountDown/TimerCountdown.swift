//
//  TimerCountdown.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 10/4/23.
//

import Foundation
import SwiftUI


struct TimerCountdown: View {
//    let calendar = Calendar(identifier: .gregorian)
//    let timeValue = calendar.dateComponents([.day, .hour, .minute, .second], from: nowDate, to: setDate)
    @State var nowDate: Date = Date()
    @Binding var count: Int
    @Binding var setDate: Date
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.nowDate = Date()
        }
    }
    
//    init() {
//        <#statements#>
//    }
    
    
    var body: some View {
        
        HStack {
            Text(timerFunction(from: setDate))
            Text("\(count)")
        }
    }
    
    func timerFunction(from date: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let timeValue = calendar.dateComponents([.day, .hour, .minute, .second], from: nowDate, to: setDate)
        print("""
    ddddddd: \(String(format: "%02dd %02dh %02dm %02ds",
                 timeValue.day!,
                 timeValue.hour!,
                 timeValue.minute!,
                 timeValue.second!))
    """)
        return String(format: "%02dd %02dh %02dm %02ds",
                      timeValue.day!,
                      timeValue.hour!,
                      timeValue.minute!,
                      timeValue.second!)
    }
}


//struct TimerCountdown_Previews: PreviewProvider {
//    static var previews: some View {
//        TimerCountdown(setDate: Date())
//    }
//}
