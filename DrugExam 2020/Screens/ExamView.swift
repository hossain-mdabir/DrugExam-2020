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
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var qesDatas: [QuestionInfo] = []
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    // MARK: - FUNCTIONS
    // Get data from DB to show in screen or refresh screen
    func getQestionData() {
        self.qesDatas.removeAll()
        
        let qesList: [QuestionInfo] = QuestionData().getQuestion()
        for p in qesList {
            self.qesDatas.append(p)
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
                                
                            }, label: {
                                Text("Collapse All")
                                    .foregroundColor(Color.black)
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                    .background(Color.white)
                                    .cornerRadius(5)
                            })
                            Button(action: {
                                
                            }, label: {
                                Text("Expand All")
                                    .foregroundColor(Color.black)
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                    .background(Color.white)
                                    .cornerRadius(5)
                            })
                            Button(action: {
                                
                            }, label: {
                                Text("Marked Question")
                                    .foregroundColor(Color.black)
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                    .background(Color.white)
                                    .cornerRadius(5)
                            })
                        }
                        
                        HStack {
                            Button(action: {
                                
                            }, label: {
                                Text("All Question")
                                    .foregroundColor(Color.black)
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                    .background(Color.white)
                                    .cornerRadius(5)
                            })
                            Button(action: {
                                
                            }, label: {
                                Text("Answered")
                                    .foregroundColor(Color.black)
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                    .background(Color.white)
                                    .cornerRadius(5)
                            })
                            Button(action: {
                                
                            }, label: {
                                Text("Unanswered")
                                    .foregroundColor(Color.black)
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                    .background(Color.white)
                                    .cornerRadius(5)
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
                
                let isOpen = true
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
                        
                        DropdownView(questionInfo: qesDatas[data],isOpen: isOpen, isStar: isStar)
                    }
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            getQuestionInfo()
//            {
//                (response, error) in
//                print("Insertinggg22-- \(response?.statusCode)")
//                if response?.statusCode == 200 {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                        getQestionData()
//                let qesList: [QuestionInfo] = QuestionData().getQuestion()
//                for p in qesList {
//                    self.qesDatas.append(p)
//                }
//
//                print("qesDatas-- \(qesDatas.count)")
//                    }
//                }
//            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let qesList: [QuestionInfo] = QuestionData().getQuestion()
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
