//
//  ExamView.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 31/3/23.
//

import SwiftUI

struct ExamView: View {
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("0h 37m 46s")
                        .font(.title2.weight(.bold))
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, minHeight: 60)
                    
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
                                .font(.title3)
                                .foregroundColor(Color.black)
                                .frame(maxWidth: .infinity, maxHeight: 60)
                                .background(Color.white)
                                .cornerRadius(5)
                        })
                        Button(action: {
                            
                        }, label: {
                            Text("Expand All")
                                .font(.title3)
                                .foregroundColor(Color.black)
                                .frame(maxWidth: .infinity, maxHeight: 60)
                                .background(Color.white)
                                .cornerRadius(5)
                        })
                        Button(action: {
                            
                        }, label: {
                            Text("Marked Question")
                                .font(.title3)
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
                                .font(.title3)
                                .foregroundColor(Color.black)
                                .frame(maxWidth: .infinity, maxHeight: 60)
                                .background(Color.white)
                                .cornerRadius(5)
                        })
                        Button(action: {
                            
                        }, label: {
                            Text("Answered")
                                .font(.title3)
                                .foregroundColor(Color.black)
                                .frame(maxWidth: .infinity, maxHeight: 60)
                                .background(Color.white)
                                .cornerRadius(5)
                        })
                        Button(action: {
                            
                        }, label: {
                            Text("Unanswered")
                                .font(.title3)
                                .foregroundColor(Color.black)
                                .frame(maxWidth: .infinity, maxHeight: 60)
                                .background(Color.white)
                                .cornerRadius(5)
                        })
                    }
                }
                .padding(5)
            }
            .background(Color("NavBar"))
            .padding(.top, 1)
            
            
            
            let isOpen = false
            let isStar = false
            DropdownView(isOpen: isOpen, isStar: isStar)
            
            let isOpen2 = false
            let isStar2 = false
            DropdownView(isOpen: isOpen2, isStar: isStar2)
            
            
            DisclosureGroup("Q1. What is Silofast?") {
                VStack(alignment: .leading) {
                    Text("A . Preparation of Dutasteride")
                    Text("B . Preparation of Tamsulosin")
                    Text("C . Preparation of Silodosin")
                    Text("D . Both A & B")
                }
                .font(.title3.weight(.semibold))
            }
            .frame(width: 300)
            
            DisclosureGroup("Q2. What is Silofast?") {
                VStack(alignment: .leading) {
                    Text("A . Preparation of Dutasteride")
                    Text("B . Preparation of Tamsulosin")
                    Text("C . Preparation of Silodosin")
                    Text("D . Both A & B")
                }
                .font(.title3.weight(.semibold))
            }
            .frame(width: 300)

            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ExamView_Previews: PreviewProvider {
    static var previews: some View {
        ExamView()
    }
}
