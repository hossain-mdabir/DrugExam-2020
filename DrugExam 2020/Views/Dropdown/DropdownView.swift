//
//  DropdownView.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 31/3/23.
//

import SwiftUI

struct DropdownView: View {
    
    @State var questionInfo: QuestionInfo
    @State var isOpen: Bool
    @State var isStar: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                withAnimation { self.isOpen.toggle() }
            }, label: {
                HStack {
                    Image(systemName: "chevron.down")
                        .font(.title3.weight(.bold))
                        .foregroundColor(Color.black)
                        .rotationEffect(.degrees(isOpen ? -180 : 0))
                        .padding(5)
                    
                    Text("\(questionInfo.questionNo ?? "") \(questionInfo.questionName ?? "")")
                        .font(.title3.weight(.semibold))
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Button(action: {
                        withAnimation { self.isStar.toggle() }
                    }, label: {
                        Image(systemName: isStar ? "star.fill" : "star")
                            .font(.title3)
                    })
                }
                .padding(8)
            })
            .foregroundColor(Color.white)
            .background(Color("NavBar").opacity(0.7))
            
            if isOpen {
                VStack(alignment: .leading, spacing: 5) {
                    Text("A . \(questionInfo.choiceA ?? "")")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("B . \(questionInfo.choiceB ?? "")")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("C . \(questionInfo.choiceC ?? "")")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("D . \(questionInfo.choiceD ?? "")")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.vertical, 3)
                .padding(.leading, 20)
                .font(.title3.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct DropdownView_Previews: PreviewProvider {
    static var previews: some View {
        DropdownView(questionInfo: QuestionInfo(), isOpen: true, isStar: true)
    }
}
