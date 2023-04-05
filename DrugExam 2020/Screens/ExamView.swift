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
                        
                        postExam()
                        
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
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
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
    }
    
    // Question Data
    func qesData() -> [QuestionInfo] {
        
        var qesPaper: [QuestionInfo] = []
        
        let qesList: [QuestionInfo] = QuestionData().getQuestion(queryData: "all", queryType: "all")
        
        for p in qesList {
            qesPaper.append(p)
        }
        print("qesPaper-- \(qesPaper.count)")
        return qesPaper
    }
    
    // Per-Question Mark
    func perQesMark() -> Double {
        let perQesMark = Double(upcomingExamData.totalMarks ?? 0) / Double(upcomingExamData.totalQuestion ?? 0)
//        print("perQesMark-- : \(upcomingExamData.totalQuestion) - \(upcomingExamData.totalMarks)")
        print("perQesMark-- : \(perQesMark)")
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
        print("obtainMark func main \(obtainMark)")
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
        
        print("obtainMark func 1 \(obtainMark())")
        print("grade func 1 \(grade)")
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
        
        var qesPaper: [ResultDetail] = []
        
        var post = ExamPostModel()
        post.examNo = upcomingExamData.examNo
        post.gpa = gpa()
        post.grade = grade()
        post.mrCode = UserData().readStringData(key: UserData().USER_CODE)
        post.obtainMarks = obtainMark()
        
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
            
        }
    }
}

struct ExamView_Previews: PreviewProvider {
    static var previews: some View {
        ExamView(upcomingExamData: UpcomingExamData())
    }
}
