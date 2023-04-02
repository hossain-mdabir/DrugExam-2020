//
//  DashboardView.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 30/3/23.
//

import SwiftUI

struct DashboardView: View {
    // MARK: - PROPERTY
    @StateObject var upcomingExamInfo = UpcomingExamInfo()
    
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("\(upcomingExamInfo.upcomingExamData.remainingTime ?? "")")
                        .font(.title2)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(Color("NavBar"))
                }
                .padding(.top, 1)
                
                VStack {
                    Text("\(upcomingExamInfo.upcomingExamData.examName ?? "")")
                    
                    Divider()
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Exam Date")
                            Text("Start Time")
                            Text("Duration")
                        }
                        Spacer()
                        VStack(alignment: .leading, spacing: 10) {
                            Text("\(upcomingExamInfo.upcomingExamData.examDateTime ?? "")")
                            Text("\(upcomingExamInfo.upcomingExamData.examName ?? "")")
                            Text("\(upcomingExamInfo.upcomingExamData.examDuration ?? 0) minutes")
                        }
                        Spacer()
                    }
                    Text("Exam button will be activated on exam time")
                        .foregroundColor(Color("NavBar"))
                }
                .padding(5)
                .font(.system(size: 16, weight: .bold))
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 3, y: 3)
                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: -3, y: -3)
                .padding(10)
                
                
                HStack(spacing: 10) {
                    NavigationLink(destination: ExamView()) {
                        VStack {
                            ZStack {
                                Circle()
                                    .stroke(Color("NavBar"), lineWidth: 10)
                                    .frame(width: 70, height: 70, alignment: .center)
                                Text("START")
                                    .font(.system(size: 16, weight: .heavy))
                                    .foregroundColor(Color("NavBar"))
                            }
                            
                            Text("START EXAM")
                                .font(.title3.weight(.bold))
                                .foregroundColor(Color.primary)
                                .padding(.vertical)
                        }
                        .frame(maxWidth: .infinity, minHeight: 200)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: ExamResultView()) {
                        VStack {
                            Image("exam")
                                .resizable()
                                .foregroundColor(Color("NavBar"))
                                .frame(width: 70, height: 70, alignment: .center)
                            
                            Text("EXAM RESULT")
                                .font(.title3.weight(.bold))
                                .foregroundColor(Color.primary)
                                .padding(.vertical)
                        }
                        .frame(maxWidth: .infinity, minHeight: 200)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 10)
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text("Instruction")
                            .font(.title.weight(.bold))
                        .foregroundColor(Color("NavBar"))
                        .padding(.leading)
                        Spacer()
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Circle()
                                .frame(width: 5, height: 5, alignment: .center)
                            Text("Multiple Choice Question")
                        }
                        HStack {
                            Circle()
                                .frame(width: 5, height: 5, alignment: .center)
                            Text("No Negative marking")
                        }
                        HStack {
                            Circle()
                                .frame(width: 5, height: 5, alignment: .center)
                            Text("Each Question contain equal marks")
                        }
                    }
                    .padding(.leading, 40)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color.gray)
                }
                .multilineTextAlignment(.leading)
                Spacer()
            }
        }
        .onAppear {
            upcomingExamInfo.getUpcomingExamInfo { (response, error) in
                
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
