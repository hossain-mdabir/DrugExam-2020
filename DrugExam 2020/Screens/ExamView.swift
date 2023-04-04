//
//  ExamView.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 31/3/23.
//

import SwiftUI

struct ExamView: View {
    
    // MARK: - PROPERTY
    // Dismiss view
    @State private var buttonOffset: CGSize = .zero
    @State private var isButtonHidden: Bool = false
    @State private var buttonOpacity: Double = 1
    
    @State var isOpen = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var qesDatas: [QuestionInfo] = []
    @State private var queryData = "all"
    @State private var queryType = "all"
    
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
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
    
//    func updateQestionData() {
//        self.qesDatas.removeAll()
//
//        let qesList: [QuestionInfo] = QuestionData().getQuestion(queryData: queryData, queryType: queryType)
//
//        for p in qesList {
//            self.qesDatas.append(p)
//        }
//
//        print("qesDatas-- \(qesDatas.count)")
//    }
    
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
                
                let isStar = false
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
                    ForEach(0 ..< qesDatas.count, id: \.self) { data in
                        
                        DropdownView(questionInfo: qesDatas[data], isOpen: isOpen)
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
        })
    }
}

struct ExamView_Previews: PreviewProvider {
    static var previews: some View {
        ExamView()
    }
}
