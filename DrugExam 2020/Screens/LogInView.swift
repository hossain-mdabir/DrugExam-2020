//
//  LogInView.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 29/3/23.
//

import SwiftUI

struct LogInView: View {
    
    @State private var userid = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            VStack {
                Image("drug-120")
                Spacer()
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(Color.black)
                    
                    FloatingTextField(title: "username", text: $userid)
                }
                
                Divider()
                
                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(Color.black)
                    
                    FloatingSecureTextField(title: "password", text: $password, isSecure: true)
                }
                
                Divider()
                
                NavigationLink(destination: DashboardView(), label: {
                    Text("L O G I N")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.red)
                        .cornerRadius(15)
                })
                
//                Button(action: {
//
//                }, label: {
//                    Text("L O G I N")
//                        .fontWeight(.bold)
//                        .foregroundColor(Color.white)
//                        .frame(maxWidth: .infinity, minHeight: 50)
//                        .background(Color.red)
//                        .cornerRadius(15)
//                })
//                .padding(.vertical, 50)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
