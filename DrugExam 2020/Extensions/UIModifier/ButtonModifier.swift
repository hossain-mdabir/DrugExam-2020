//
//  ButtonModifier.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 4/4/23.
//

import Foundation
import SwiftUI

extension Text {
    func buttonModifier() -> some View {
        self
            .foregroundColor(Color.black)
            .frame(maxWidth: .infinity, maxHeight: 60)
            .background(Color.white)
            .cornerRadius(5)
    }
}
