//
//  ExamView.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 31/3/23.
//

import SwiftUI
import UIKit

struct ExamView: View {
    
    // MARK: - PROPERTY
    @Binding var upcomingExam : UpcomingExam
    @StateObject var questionInfos = QuestionInfos()
    
    // Dismiss view
    @State private var buttonOffset: CGSize = .zero
    @State private var isButtonHidden: Bool = false
    @State private var buttonOpacity: Double = 1
    
    @State var isOpen = false
    
    // Dismiss view
    @Environment(\.dismiss) var dismiss//.presentationMode: Binding<PresentationMode>
    
    @State var qesDatas: [QuestionInfo] = []
    @State private var queryData = "all"
    @State private var queryType = "all"
    
    @State private var allQes = 0
    @State private var answeredQes = 0
    @State private var notAnsweredQes = 0
    @State private var markedQes = 0
    
    @State private var isSubmitPopUp: Bool = false
    @State private var isSubmittedPopUp: Bool = false
    @State private var examRes = ResultInfo()
    @State private var milSecToSec: Int64 = 0
    
    //Loading Animation
    @State var isLoadingAnimation: Bool = false
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @StateObject var timeCounter = TimeCounter()
    @StateObject var examDuration = ExamDuration()
    @State private var isExamPost: Bool = false
    
    
//    init() {
//    UIScrollView.appearance().bounces = false
//    }
    
    // MARK: - FUNCTIONS
    // Get data from DB to show in screen or refresh screen
    func getQestionData() {
        self.qesDatas.removeAll()
        
        let qesList: [QuestionInfo] = QuestionData().getQuestion(queryData: queryData, queryType: queryType)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if qesDatas.count == 0 {
            for p in qesList {
                    self.qesDatas.append(p)
                }
            }
        }
        
        print("qesDatas-- \(qesDatas.count)")
    }
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    HStack {
                        Button {
                            // Dismiss from view
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.title3.weight(.bold))
                                .foregroundColor(Color.white)
                                .padding(.horizontal, 5)
                        }
                        
                        Text("\(examDuration.timeRead)")
                            .font(.title2.weight(.bold))
                            .foregroundColor(Color.white)
                            .padding(10)
                        
                        Spacer()
                        Button(action: {
                            print("perQesMark \(perQesMark())")
                            print("obtainMark1 \(obtainMark())")
                            print("grade \(grade())")
                            print("gpa \(gpa())")
                            
                            // Update Exam Status (UI)
                            updateExam()
                            
                            withAnimation { self.isSubmitPopUp = true }
                        }, label: {
                            Text("SUBMIT EXAM")
                                .font(.title2.weight(.bold))
                                .foregroundColor(Color.white)
                                .padding(10)
                        })
                    }
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .onReceive(timer) { _ in
                        
                        if milSecToSec > 0 {
                            milSecToSec -= 1
                            
                            examDuration.updateCounter(counter: milSecToSec)
                            
                            if !isExamPost {
                                if milSecToSec <= 0 {
                                    postExam()
                                } else {
                                    print("Exam will not be submitted")
                                }
                            }
                        }
                    }
                    
                    VStack {
                        if !isButtonHidden {
                            HStack {
                                Button(action: {
                                    withAnimation {
                                        isOpen = false
                                        getQestionData()
                                    }
                                }, label: {
                                    HStack(spacing: 0) {
                                        Image(systemName: "list.bullet")
                                            .foregroundColor(Color("NavBar"))
                                        Text("Collapse All")
                                    }
                                    .buttonModifier()
                                })
                                Button(action: {
                                    withAnimation {
                                        isOpen = true
                                        getQestionData()
                                    }
                                }, label: {
                                    HStack(spacing: 0) {
                                        Image(systemName: "list.bullet")
                                            .foregroundColor(Color("NavBar"))
                                        Text("Expand All")
                                    }
                                    .buttonModifier()
                                })
                                Button(action: {
                                    queryData = "1"
                                    queryType = "bookmark"
                                    getQestionData()
                                }, label: {
                                    HStack(spacing: 0) {
                                        ZStack {
                                            Image(systemName: "circle.fill")
                                                .font(.title2)
                                                .foregroundColor(Color("NavBar"))
                                            Text("\(markedQes)")
                                                .foregroundColor(Color.white)
                                        }
                                        Text("Marked Question")
                                    }
                                    .buttonModifier()
                                })
                            }
                        }
                        
                        HStack {
                            Button(action: {
                                queryData = "all"
                                queryType = "all"
                                getQestionData()
                            }, label: {
                                HStack(spacing: 0) {
                                    ZStack {
                                        Image(systemName: "circle.fill")
                                            .font(.title2)
                                            .foregroundColor(Color("NavBar"))
                                        Text("\(allQes)")
                                            .foregroundColor(Color.white)
                                    }
                                    Text("All Question")
                                }
                                .buttonModifier()
                            })
                            Button(action: {
                                queryData = ""
                                queryType = "ans"
                                getQestionData()
                            }, label: {
                                HStack(spacing: 0) {
                                    ZStack {
                                        Image(systemName: "circle.fill")
                                            .font(.title2)
                                            .foregroundColor(Color("NavBar"))
                                        Text("\(answeredQes)")
                                            .foregroundColor(Color.white)
                                    }
                                    Text("Answered")
                                }
                                .buttonModifier()
                            })
                            Button(action: {
                                queryData = ""
                                queryType = "notAns"
                                getQestionData()
                            }, label: {
                                HStack(spacing: 0) {
                                    ZStack {
                                        Image(systemName: "circle.fill")
                                            .font(.title2)
                                            .foregroundColor(Color("NavBar"))
                                        Text("\(notAnsweredQes)")
                                            .foregroundColor(Color.white)
                                    }
                                    Text("Unanswered")
                                }
                                .buttonModifier()
                            })
                        }
                    }
                    .font(.title3)
                    .padding(5)
                }
                .background(Color("NavBar"))
                .padding(.bottom, isButtonHidden ? -3 : -14)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0.5) {
                        GeometryReader { geometry in
                            
//                        Text("Top View \(geometry.frame(in: .global).midY)--\(buttonOpacity)")
                            Text("")
                                .frame(width: 0, height: 0)
                                .background(Color.orange)
                                .onChange(of: geometry.frame(in: .global).midY, perform: { _ in
                                    if geometry.frame(in: .global).midY < buttonOpacity {
                                        withAnimation { isButtonHidden = true }
                                    } else if geometry.frame(in: .global).midY > buttonOpacity {
                                        withAnimation { isButtonHidden = false}
                                    }
                                    buttonOpacity = geometry.frame(in: .global).midY
                                })
//                            .gesture(
//                                DragGesture()
//                                    .onChanged { gesture in
//                                        if gesture.translation.height < 0 {
//                                            isButtonHidden = true
//                                            buttonOpacity = 0
//                                            print("isButtonHidden : \(isButtonHidden)")
//                                        } else {
//                                            isButtonHidden = false
//                                            buttonOpacity = 1
//                                            print("isButtonHidden1 : \(isButtonHidden)")
//                                        }
//
//                                        //                                        if abs(buttonOffset.height) <= 5 {
//                                        //                                            buttonOffset = gesture.translation
//                                        //
//                                        //                                            withAnimation(.linear(duration: 0.25)) {
//                                        //                                                isButtonHidden = true
//                                        //                                            }
//                                        //                                        }
//                                    }
//                                    .onEnded { gesture in
//                                        buttonOpacity = geometry.frame(in: .global).midY
//                                        buttonOffset = .zero
//
//                                        withAnimation(.linear(duration: 0.25)) {
//
//                                        }
//                                    }
//                            ) //: GESTURE
                        }
                        if qesDatas.count > 0 {
                            ForEach(0 ..< qesDatas.count, id: \.self) { data in
                                
                                DropdownView(questionInfo: qesDatas[data], isOpen: isOpen, allQes: $allQes, answeredQes: $answeredQes, notAnsweredQes: $notAnsweredQes, markedQes: $markedQes)
                            }
                        } else {
                            Text("No Q. found in this Filter")
                        }
                    }
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)
            .preferredColorScheme(.light)
            .onAppear(perform: {
                milSecToSec = ((upcomingExam.objResponse?.remaingTimeInMiliSec ?? 0) / 1000)
                examDuration.updateCounter(counter: milSecToSec)
                
                self.isLoadingAnimation = true // Loading starts
                
                questionInfos.getQuestionInfo { (response, error) in
                    if response?.statusCode == 200 {
                        if QuestionData().getQuestion(queryData: "all", queryType: "all").count > 0 {
                            
                            let qesList: [QuestionInfo] = QuestionData().getQuestion(queryData: "all", queryType: "all")
                            for p in qesList {
                                self.qesDatas.append(p)
                            }
                            
                            // Update Exam Status (UI)
                            if qesDatas.count > 0 {
                                updateExam()
                            }
                            print("qesDatas-- \(qesDatas.count)")
                            
                            self.isLoadingAnimation = false // Loading stops
                        }
                    } else {
                        
                    }
                }
                
                // Scroll bouncing effect on/off
                UIScrollView.appearance().bounces = false
            })
            
            
            // MARK: - PopUp's
            // Order post confirmation PopUp
            if isSubmitPopUp {
                Color.gray
                    .opacity(0.5)
                examSubmitPopUp()
                    .cornerRadius(5)
                    .padding(.horizontal, 40)
                    .zIndex(1)
            }
            
            // Order post PopUp
            if isSubmittedPopUp {
                Color.gray
                    .opacity(0.5)
                examSubmittedPopUp()
                    .cornerRadius(5)
                    .padding(.horizontal, 40)
                    .zIndex(1)
            }
            
            // Loading Animation
            if self.isLoadingAnimation {
                VStack(alignment: .center) {
                    LoadingAnimationCircle()
                        .frame(alignment: .center)
                    Text("Please wait...")
                        .foregroundColor(Color.gray)
                }
                .zIndex(2)
            }
        }
    }
    
    // MARK: - Exam Submission PopUp
    @ViewBuilder
    func examSubmitPopUp() -> some View {
            VStack {
                VStack(alignment: .center) {
                    Text("Submission Alert!!!")
                        .font(.title3)
                        .foregroundColor(Color("NavBar"))
                        .frame(maxWidth: .infinity, maxHeight: 40)
                }
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 3, y: 0)
                .shadow(color: Color.gray.opacity(0.3), radius: 3, x: -3, y: 0)
                .padding(.bottom, 2)
                    
                VStack(alignment: .leading, spacing: 5) {
                    Text("Total Question: \(upcomingExam.objResponse?.totalQuestion ?? 0)")
                        .foregroundColor(Color.primary)
                    Text("Answered: \(answeredQes)")
                        .foregroundColor(Color.green)
                    Text("Not Answered: \(notAnsweredQes)")
                        .foregroundColor(Color("NavBar"))
                }
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
                
                HStack(spacing: 10) {
                    Spacer()
                    Button(action: {
                        withAnimation { self.isSubmitPopUp = false }
                    }, label: {
                        Text("NO")
                            .padding(.vertical, 5)
                            .padding(.horizontal)
                    })
                    
                    Button(action: {
                        postExam()
                    }, label: {
                        Text("SUBMIT")
                            .padding(.vertical, 5)
                            .padding(.horizontal)
                    })
                }
                .fontWeight(.bold)
                .foregroundColor(Color("NavBar"))
            }
        .padding(10)
        .aspectRatio(contentMode: .fit)
        .background(Color.white)
    }
    
    // MARK: - Exam Submitted PopUp
    @ViewBuilder
    func examSubmittedPopUp() -> some View {
        VStack(alignment: .leading) {
            Text("Exam Result")
                .font(.title3.weight(.semibold))
                .foregroundColor(Color("NavBar"))
                .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Obtain Mark: \(examRes.obtainMarks ?? 0.0, specifier: "%.2f")")
                Text("Grade: \(examRes.grade ?? "")")
                Text("GPA: \(examRes.gpa ?? 0.0, specifier: "%.2f")")
            }
            
            HStack {
                Spacer()
                Button(action: {
                    withAnimation { self.isSubmittedPopUp = false }
                    
                    // Go baback to Dashboard
                    dismiss()
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
    
    
    // Question Data
    func qesData() -> [QuestionInfo] {
        var qesPaper: [QuestionInfo] = []
        
        let qesList: [QuestionInfo] = QuestionData().getQuestion(queryData: "all", queryType: "all")
        
        for p in qesList {
            qesPaper.append(p)
        }
        return qesPaper
    }
    
    // Per-Question Mark
    func perQesMark() -> Double {
        let perQesMark = Double(upcomingExam.objResponse?.totalMarks ?? 0) / Double(upcomingExam.objResponse?.totalQuestion ?? 0)
//        print("perQesMark-- : \(upcomingExamData.totalQuestion) - \(upcomingExamData.totalMarks)")
        return perQesMark
    }
    
    
    // Obtain Mark
    func obtainMark() -> Double {
        var obtainMark = 0.0
        
        for mark in qesData() {
            if mark.correctAns == mark.chosenAns {
                obtainMark = obtainMark + perQesMark()
            }
        }
        return obtainMark
    }
    
    
    // Grade
    func gpa() -> Double {
        let gpa = (5 * obtainMark()) / Double(upcomingExam.objResponse?.totalMarks ?? 0)
        print("gpa func 1 \(gpa)")
        return gpa
    }
    
    
    // GPS
    func grade() -> String {
        let grade = (obtainMark() * 100) / Double(upcomingExam.objResponse?.totalMarks ?? 0)
        
        if grade > 90 {
            return "A+"
        } else if grade > 80 {
            return "A"
        } else if grade > 70 {
            return "A-"
        } else if grade > 60 {
            return "B"
        } else if grade > 50 {
            return "C"
        } else {
            return "F"
        }
    }
//    @State private var functionToPass: () -> Void = {}
    // Update Exam Status (UI)
    func updateExam() {
        // Making 0
        allQes = 0
        answeredQes = 0
        notAnsweredQes = 0
        markedQes = 0
        
        
        // Question count
        for p in qesData() {
            allQes += 1 // All Qes
            if p.chosenAns != "N" {
                answeredQes += 1 // Answered Qes
            } else if p.chosenAns == "N" {
                notAnsweredQes += 1 // unAnswered Qes
            }
            
            // Marked Qes
            if p.bookmark == "1" {
                markedQes += 1 // Marked Qes
            }
        }
    }
    
    
    // Exam POST
    func postExam() {
        withAnimation {
            isLoadingAnimation = true
        }
        
        var qesPaper: [ResultDetail] = []
        
        var post = ExamPostModel()
        post.examNo = upcomingExam.objResponse?.examNo
        post.gpa = gpa()
        post.grade = grade()
        post.mrCode = UserData().readStringData(key: UserData().USER_CODE)
        post.obtainMarks = obtainMark()
        
        
        // Question count
        for p in qesData() {
            var pp = ResultDetail()
            pp.choosenAns = p.chosenAns
            pp.examNo = upcomingExam.objResponse?.examNo
            pp.givenAns = p.correctAns
            pp.mrCode = UserData().readStringData(key: UserData().USER_CODE)
            pp.quesNo = p.questionNo
            
            qesPaper.append(pp)
        }
        post.resultDetails = qesPaper
        
        examPost(post: post) { (response, error) in
            if response?.statusCode == 200 {
                examRes = response?.objResponse ?? ResultInfo()
                
                // Exam posted flag
                isExamPost = true
                
                // Delete all stored questions on successful submission
                QuestionData().deleteAllQuestion()

                withAnimation {
                    self.isLoadingAnimation = false
                    self.isSubmitPopUp = false
                    self.isSubmittedPopUp = true
                }
                
            } else {
                if error != nil {
                    withAnimation {
                        self.isLoadingAnimation = false
                    }
                }
            }
        }
    }
}

struct ExamView_Previews: PreviewProvider {
    @State static var upcomingExam = UpcomingExam()
    static var previews: some View {
        ExamView(upcomingExam: $upcomingExam)
    }
}
