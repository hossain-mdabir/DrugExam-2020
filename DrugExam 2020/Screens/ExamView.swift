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
    @State var upcomingExamData : UpcomingExamData
    // Dismiss view
    @State private var buttonOffset: CGSize = .zero
    @State private var isButtonHidden: Bool = false
    @State private var buttonOpacity: Double = 1
    
    @State var isOpen = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var qesDatas: [QuestionInfo] = []
    @State private var queryData = "all"
    @State private var queryType = "all"
    
    @State private var answeredQes = 0
    @State private var notAnsweredQes = 0
    
    @State private var isSubmitPopUp: Bool = false
    @State private var isSubmittedPopUp: Bool = false
    @State private var examRes = ResultInfo()
    
    //Loading Animation
    @State var isLoadingAnimation: Bool = false
    
    
    
//    init() {
//    UIScrollView.appearance().bounces = false
//    }
    
    // MARK: - FUNCTIONS
    // Get data from DB to show in screen or refresh screen
    func getQestionData() {
        self.qesDatas.removeAll()
        
        let qesList: [QuestionInfo] = QuestionData().getQuestion(queryData: queryData, queryType: queryType)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            for p in qesList {
                self.qesDatas.append(p)
            }
        }
        
        print("qesDatas-- \(qesDatas.count)")
    }
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    HStack {
                        Button(action: {
                            self.mode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .font(.title3.weight(.bold))
                                .foregroundColor(Color.white)
                                .padding(.horizontal, 5)
                        })
                        Text("0h 37m 46s")
                            .font(.title2.weight(.bold))
                            .foregroundColor(Color.white)
                            .frame(minHeight: 60)
                        Spacer()
                        Button(action: {
                            print("perQesMark \(perQesMark())")
                            print("obtainMark1 \(obtainMark())")
                            print("grade \(grade())")
                            print("gpa \(gpa())")
                            
                            // Making 0
                            answeredQes = 0
                            notAnsweredQes = 0
                            
                            // Question count
                            for p in qesData() {
                                if p.chosenAns != "N" {
                                    answeredQes += 1
                                } else if p.chosenAns == "N" {
                                    notAnsweredQes += 1
                                }
                            }
                            
                            withAnimation { self.isSubmitPopUp = true }
                        }, label: {
                            Text("SUBMIT EXAM")
                                .font(.title2.weight(.bold))
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, minHeight: 60)
                        })
                    }
                    
                    if !isButtonHidden {
                        VStack {
                            HStack {
                                Button(action: {
                                    withAnimation {
                                        isOpen = false
                                        getQestionData()
                                    }
                                }, label: {
                                    Text("Collapse All")
                                        .buttonModifier()
                                })
                                Button(action: {
                                    withAnimation {
                                        isOpen = true
                                        getQestionData()
                                    }
                                }, label: {
                                    Text("Expand All")
                                        .buttonModifier()
                                })
                                Button(action: {
                                    queryData = "1"
                                    queryType = "bookmark"
                                    getQestionData()
                                }, label: {
                                    Text("Marked Question")
                                        .buttonModifier()
                                })
                            }
                            
                            HStack {
                                Button(action: {
                                    queryData = "all"
                                    queryType = "all"
                                    getQestionData()
                                }, label: {
                                    Text("All Question")
                                        .buttonModifier()
                                })
                                Button(action: {
                                    queryData = ""
                                    queryType = "ans"
                                    getQestionData()
                                }, label: {
                                    Text("Answered")
                                        .buttonModifier()
                                })
                                Button(action: {
                                    queryData = ""
                                    queryType = "notAns"
                                    getQestionData()
                                }, label: {
                                    Text("Unanswered")
                                        .buttonModifier()
                                })
                            }
                        }
                        .font(.title3)
                        .padding(5)
                    }
                }
                .background(Color("NavBar"))
                .padding(.top, 1)
                
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
                                
                                DropdownView(questionInfo: qesDatas[data], isOpen: isOpen)
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
                getQuestionInfo()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let qesList: [QuestionInfo] = QuestionData().getQuestion(queryData: "all", queryType: "all")
                    for p in qesList {
                        self.qesDatas.append(p)
                    }
                    print("qesDatas-- \(qesDatas.count)")
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
            }
            
            // Order post PopUp
            if isSubmittedPopUp {
                Color.gray
                    .opacity(0.5)
                examSubmittedPopUp()
                    .cornerRadius(5)
                    .padding(.horizontal, 40)
            }
        }
    }
    
    // MARK: - Exam Submission PopUp
    @ViewBuilder
    func examSubmitPopUp() -> some View {
        ZStack {
            // Loading Animation
            VStack(alignment: .center) {
                if self.isLoadingAnimation {
                    LoadingAnimationCircle()
                        .frame(alignment: .center)
                    Text("Please wait...")
                        .foregroundColor(Color.gray)
                }
            }
            
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
                    Text("Total Question: \(upcomingExamData.totalQuestion ?? 0)")
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
        let perQesMark = Double(upcomingExamData.totalMarks ?? 0) / Double(upcomingExamData.totalQuestion ?? 0)
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
        let gpa = (5 * obtainMark()) / Double(upcomingExamData.totalMarks ?? 0)
        print("gpa func 1 \(gpa)")
        return gpa
    }
    
    
    // GPS
    func grade() -> String {
        let grade = (obtainMark() * 100) / Double(upcomingExamData.totalMarks ?? 0)
        
        if grade > 90 {
            return "A+"
        } else if grade > 80 {
            return "A"
        } else if grade > 70 {
            return "A-"
        } else if grade > 60 {
            return "B-"
        } else if grade > 50 {
            return "C"
        } else {
            return "F"
        }
    }
    
    
    // Exam POST
    func postExam() {
        withAnimation {
            isLoadingAnimation = true
        }
        
        var qesPaper: [ResultDetail] = []
        
        var post = ExamPostModel()
        post.examNo = upcomingExamData.examNo
        post.gpa = gpa()
        post.grade = grade()
        post.mrCode = UserData().readStringData(key: UserData().USER_CODE)
        post.obtainMarks = obtainMark()
        
        
        // Question count
        for p in qesData() {
            var pp = ResultDetail()
            pp.choosenAns = p.chosenAns
            pp.examNo = upcomingExamData.examNo
            pp.givenAns = p.correctAns
            pp.mrCode = UserData().readStringData(key: UserData().USER_CODE)
            pp.quesNo = p.questionNo
            
            qesPaper.append(pp)
        }
        post.resultDetails = qesPaper
        
        examPost(post: post) { (response, error) in
            if response?.statusCode == 200 {
                examRes = response?.objResponse ?? ResultInfo()

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
    static var previews: some View {
        ExamView(upcomingExamData: UpcomingExamData())
    }
}
