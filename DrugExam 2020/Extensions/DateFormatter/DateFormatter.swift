//
//  DateFormatter.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 15/4/23.
//

import Foundation

extension Date {
    func getDate(dateStr: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short//"hh:mm'a'"
        return dateFormatter.date(from: dateStr) // replace Date String
    }
}
