//
//  DashboardView.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 30/3/23.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Exam Already Started")
                        .font(.title2)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(Color("NavBar"))
                }
                
                VStack {
                    Text("BHP, Anti-Histamin")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
