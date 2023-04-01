//
//  ExamResultView.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 30/3/23.
//

import SwiftUI

struct ExamResultView: View {
    
    // MARK: - PROPERTY
    
    // Dismiss view
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var width = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: {
                        self.mode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .font(.title3.weight(.bold))
                            .padding(.horizontal, 5)
                    })
                    Text("Previous Exam Info of User:")
                        .font(.title2)
                        .frame(maxWidth: .infinity, minHeight: 60, alignment: .leading)
                }
                .foregroundColor(Color.white)
                .background(Color.red)
                .padding(.top, 1)
                
                ForEach(0...1, id: \.self) { _ in
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Exam No: \("81")")
                            Spacer()
                            Text("Date: \("Mon, 27-Mar-2023")")
                            Spacer()
                        }
                        .foregroundColor(Color.red)
                        .font(.system(size: width > 600 ? 25 : 18))
                        
                        Text("EXAM MARCH -23")
                            .foregroundColor(Color.gray)
                        
                        HStack {
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Total Marks")
                                    Text("Obtain Markas")
                                }
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("50")
                                    Text("38.0")
                                }
                                .foregroundColor(Color.gray)
                            }
                            Spacer()
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Duration")
                                    Text("Obtain Markas")
                                }
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("50")
                                    Text("A+")
                                }
                                .foregroundColor(Color.gray)
                            }
                            Spacer()
                        }
                        .font(.system(size: width > 600 ? 18 : 16))
                    }
                    .padding(10)
                    .font(.system(size: 16))
                    .foregroundColor(Color.primary)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 3, y: 3)
                    .shadow(color: Color.gray.opacity(0.3), radius: 5, x: -3, y: -3)
                    .padding(10)
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ExamResultView_Previews: PreviewProvider {
    static var previews: some View {
        ExamResultView()
    }
}
