//
//  ExamResultView.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 30/3/23.
//

import SwiftUI

struct ExamResultView: View {
    
    // MARK: - PROPERTY
    @StateObject var examResultInfo = ExamResultInfo()
    
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
                .background(Color("NavBar"))
                .padding(.top, 1)
                
//                ForEach(0...1, id: \.self) { _ in
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Exam No: \(examResultInfo.examResultData.examNo ?? 0)")
                            Spacer()
                            Text("Date: \(examResultInfo.examResultData.examDate ?? "")")
                            Spacer()
                        }
                        .foregroundColor(Color.red)
                        .font(.system(size: width > 600 ? 25 : 18))
                        
                        Text("\(examResultInfo.examResultData.examname ?? "")")
                            .foregroundColor(Color.gray)
                        
                        HStack {
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Total Marks")
                                    Text("Obtain Markas")
                                }
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("\(examResultInfo.examResultData.totalmarks ?? 0)")
                                    Text("\(examResultInfo.examResultData.obtainMarks ?? 0.0, specifier: "%.1f")")
                                }
                                .foregroundColor(Color.gray)
                            }
                            Spacer()
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Duration")
                                    Text("Obtain Grade")
                                }
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("\(examResultInfo.examResultData.duration ?? 0)")
                                    Text("\(examResultInfo.examResultData.grade ?? "")")
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
//                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            examResultInfo.getExamResult { (result, error) in
                
            }
        }
    }
}

struct ExamResultView_Previews: PreviewProvider {
    static var previews: some View {
        ExamResultView()
    }
}
