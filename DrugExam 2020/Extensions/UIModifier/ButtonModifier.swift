//
//  ButtonModifier.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 4/4/23.
//

import Foundation
import SwiftUI

extension View {
    func buttonModifier() -> some View {
        self
            .font(.system(size: UIScreen.main.bounds.width > 650 ? 18 : 14))
            .foregroundColor(Color.black)
            .frame(maxWidth: .infinity, maxHeight: 60)
            .background(Color.white)
            .cornerRadius(5)
    }
}
