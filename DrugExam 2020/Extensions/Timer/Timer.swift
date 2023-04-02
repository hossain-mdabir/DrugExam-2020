//
//  Timer.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 1/4/23.
//

import Foundation

//extension TimeInterval {
//
//    // Hour
//    func startHour(hour: String) -> String {
//
//        return ""
//    }
//
//    // Minute
//    func startMinute(minute: String) -> String {
//
//        return ""
//    }
//
//    // Second
//    func startSecond(second: Stride) -> String {
//
//        return ""
//    }
//}


extension TimeInterval {
    var hourMinuteSecondMS: String {
        String(format:"%d:%02d:%02d.%03d", hour, minute, second, millisecond)
    }
    var minuteSecondMS: String {
        String(format:"%d:%02d.%03d", minute, second, millisecond)
    }
//    var day: Int {
//        Int((self/3600*24).truncatingRemainder(dividingBy: 3600*24))
//    }
    var hour: Int {
        Int((self/3600).truncatingRemainder(dividingBy: 3600))
    }
    var minute: Int {
        Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        Int(truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        Int((self*1000).truncatingRemainder(dividingBy: 1000))
    }
}
