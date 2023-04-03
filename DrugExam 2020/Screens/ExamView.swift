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
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
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
            .background(Color("NavBar"))
            .padding(.top, 1)
            
            VStack(spacing: 0.5) {
                let isOpen = false
                let isStar = false
                DropdownView(isOpen: isOpen, isStar: isStar)
                
                DropdownView(isOpen: isOpen, isStar: isStar)
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            getQuestionInfo()
        }
    }
}

struct ExamView_Previews: PreviewProvider {
    static var previews: some View {
        ExamView()
    }
}
