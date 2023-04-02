//
//  DecimelLimit.swift
//  THP Online
//
//  Created by Md Abir Hossain on 12/3/23.
//

import Foundation


extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
