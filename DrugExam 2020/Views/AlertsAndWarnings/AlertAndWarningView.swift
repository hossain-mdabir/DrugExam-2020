//
//  AlertAndWarningView.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 18/4/23.
//

import SwiftUI

struct AlertAndWarningView: View {
    // MARK: - PROPERTIES
    
    @Binding var isToast: Bool
    @Binding var msg: String
    
    // MARK: - BODY
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Exam Submission")
                .font(.title2.weight(.semibold))
                .foregroundColor(Color("NavBar"))
                .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("\(msg)")
            }
            
            HStack {
                Spacer()
                Button(action: {
                    withAnimation { self.isToast = false }
                }, label: {
                    Text("Ok")
                        .padding(.vertical, 5)
                        .padding(.horizontal)
                        .fontWeight(.bold)
                        .foregroundColor(Color("NavBar"))
                })
            }
        }
        .padding()
        .aspectRatio(contentMode: .fit)
        .background(Color.white)
    }
}

// MARK: - PREVIEW

struct AlertAndWarningView_Previews: PreviewProvider {
    @State static var isToast = false
    @State static var msg = ""
    static var previews: some View {
        AlertAndWarningView(isToast: $isToast, msg: $msg)
    }
}
