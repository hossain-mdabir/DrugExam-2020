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
    
    @StateObject var timeCounter = TimeCounter()
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var milSceToSec: Int64 = 0
    
//    func toDate(toDate: Int) -> Date {
//    @State var toDate = Calendar.current.date(byAdding: .second, value: toDate, to: Date())!
//        return toDate
//    }
    @State var date = Date()
    
    @State private var goExam: Bool = false
    @State var isToast: Bool = false
    @State var msg: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    // Time count
//                    var toDate = Calendar.current.date(byAdding: .second, value: Int(milSceToSec), to: Date())!
                    
                    if milSceToSec > 0 {
//                        TimerView(milSce: milSceToSec, setDate: toDate(toDate: Int(milSceToSec)))
//                    TimerCountdown(count: $count, setDate: $date)
                        Text("\(timeCounter.timeRead)")
                    } else {
                        // Coming from API
//                        Text("\(upcomingExamInfo.upcomingExam.objResponse?.remainingTime ?? "")")
                        Text("Exam is started")
                    }
                }
                .padding(.top, 1)
                .font(.title2)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, minHeight: 60)
                .background(Color("NavBar"))
                .onReceive(timer) { _ in
                    
                    if milSceToSec > 0 {
                        milSceToSec -= 1
                        
                        if milSceToSec == 0 {
                            upcomingExamInfo.getUpcomingExamInfo { (response, error) in
                                
                                timeCounter.updateCounter(counter: milSceToSec)
                                print("timeRead \(TimeCounter().timeRead)")
                            }
                        }
                        
                        upcomingExamInfo.upcomingExam.objResponse?.remaingTimeInMiliSec = (upcomingExamInfo.upcomingExam.objResponse?.remaingTimeInMiliSec ?? 0) - 1
                        upcomingExamInfo.upcomingExam.objResponse?.countdown = timeCounter.timeRead
//                    date = Calendar.current.date(byAdding: .second, value: Int(milSceToSec), to: Date())!
                        timeCounter.updateCounter(counter: milSceToSec)
                        
                        print("milSceToSec : \(milSceToSec)")
                        print("remaingTimeInMiliSec : \(upcomingExamInfo.upcomingExam.objResponse?.remaingTimeInMiliSec ?? 0)")
                    }
                }
                
                VStack {
                    if upcomingExamInfo.upcomingExam.statusCode == 200 {
                        Text("\(upcomingExamInfo.upcomingExam.objResponse?.examName ?? "")")
                        
                        Divider()
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Exam Date")
                                Text("Start Time")
                                Text("Duration")
                            }
                            Spacer()
                            VStack(alignment: .leading, spacing: 10) {
                                Text("\(upcomingExamInfo.upcomingExam.objResponse?.examDateTime ?? "")")
                                Text("\(getDate(dateStr: upcomingExamInfo.upcomingExam.objResponse?.examDateTime ?? ""))")
                                Text("\(upcomingExamInfo.upcomingExam.objResponse?.examDuration ?? 0) minutes")
                            }
                            Spacer()
                        }
                        Text("Exam button will be activated on exam time")
                            .foregroundColor(Color("NavBar"))
                            .padding(.top, 5)
                    } else {
                        Text("No Exam Today")
                            .foregroundColor(Color("NavBar"))
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            .padding(.top, 5)
                    }
                }
                .padding(5)
                .font(.system(size: 16, weight: .bold))
                .background(Color.white)
                .cornerRadius(5)
                .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 3, y: 3)
                .shadow(color: Color.gray.opacity(0.3), radius: 3, x: -3, y: -3)
                .padding(10)
                
                NavigationLink("", destination: ExamView(upcomingExam: $upcomingExamInfo.upcomingExam), isActive: $goExam)
                
                HStack(spacing: 10) {
//                    NavigationLink(destination: ExamView(upcomingExam: $upcomingExamInfo.upcomingExam)) {
                        Button {
                            if upcomingExamInfo.upcomingExam.objResponse?.examFlag == 0 {
                                isToast = true
                                msg = "Exam not started. Please try again later."
                            } else if upcomingExamInfo.upcomingExam.objResponse?.examFlag == 2 {
                                isToast = true
                                msg = "Exam finished. Please try again later."
                            } else if upcomingExamInfo.upcomingExam.objResponse?.examFlag == 1 {
                                 if upcomingExamInfo.upcomingExam.objResponse?.examStatus == 0 {
                                     goExam = true
                                     print("Will go to give exam")
                                 } else {
                                     isToast = true
                                     msg = "Exam already submitted"
                                 }
                            } else {
                                print("Nothing will happen with exam Button")
                            }
                        } label: {
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
                                    .foregroundColor(Color.primary.opacity(upcomingExamInfo.upcomingExam.statusCode == 200 ? 1 : 0.5))
                                    .padding(.vertical)
                            }
                            .frame(maxWidth: .infinity, minHeight: 200)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                        }
//                    }
//                        .disabled(milSceToSec > 0)
                    
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
                let examTime: Int64 = Int64((upcomingExamInfo.upcomingExam.objResponse?.examDuration ?? 0) * 60)
                milSceToSec = (((upcomingExamInfo.upcomingExam.objResponse?.remaingTimeInMiliSec ?? 0) / 1000) - examTime)
                
                timeCounter.updateCounter(counter: milSceToSec)
//                TimeCounter(counter: milSceToSec)
                print("timeRead \(TimeCounter().timeRead)")

//                toDate = Calendar.current.date(byAdding: .second, value: Int(milSceToSec), to: Date())!
                print("examTime-on : \(examTime)")
                print("milSceToSec-on : \(milSceToSec)")
            }
        }
        .onDisappear {
            print("Disappearing from Dashboard")
        }
        .toastNotification(isToast: $isToast, msg: $msg)
        .navigationBarBackButtonHidden(true)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
