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
//    var funct: () -> Void
    
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
                        if questionInfo.bookmark == "1" {
                            questionInfo.bookmark = "0"
                        } else {
                            questionInfo.bookmark = "1"
                        }
                        QuestionData().updateQuestion(updateData: questionInfo.bookmark ?? "1", queryType: "bookmark", qesNo: questionInfo.questionNo ?? "")
//                        questionInfo.bookmark = "1"
                    }, label: {
                        Image(systemName: questionInfo.bookmark == "1" ? "star.fill" : "star")
                            .font(.title3)
                            .foregroundColor(Color("NavBar"))
                    })
                }
                .padding(8)
            })
            .foregroundColor(Color.white)
            .background(Color("NavBar").opacity(0.5))
            
            if isOpen {
                VStack(alignment: .leading, spacing: 5) {
                    let pri = print("chosenAns : \(questionInfo.chosenAns)")
                    let pri2 = print("questionNo : \(questionInfo.questionNo)")
                    Button(action: {
                        QuestionData().updateQuestion(updateData: "A", queryType: "ans", qesNo: questionInfo.questionNo ?? "")
                        questionInfo.chosenAns = "A"
                    }, label: {
                        Text("A . \(questionInfo.choiceA ?? "")")
                            .padding(.leading, 20)
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(questionInfo.chosenAns == "A" ? Color.green.opacity(0.3) : Color.clear)
                    })
                    Button(action: {
                        QuestionData().updateQuestion(updateData: "B", queryType: "ans", qesNo: questionInfo.questionNo ?? "")
                        questionInfo.chosenAns = "B"
                    }, label: {
                        Text("B . \(questionInfo.choiceB ?? "")")
                            .padding(.leading, 20)
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(questionInfo.chosenAns == "B" ? Color.green.opacity(0.3) : Color.clear)
                    })
                    Button(action: {
                        QuestionData().updateQuestion(updateData: "C", queryType: "ans", qesNo: questionInfo.questionNo ?? "")
                        questionInfo.chosenAns = "C"
                    }, label: {
                        Text("C . \(questionInfo.choiceC ?? "")")
                            .padding(.leading, 20)
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(questionInfo.chosenAns == "C" ? Color.green.opacity(0.3) : Color.clear)
                    })
                    Button(action: {
                        QuestionData().updateQuestion(updateData: "D", queryType: "ans", qesNo: questionInfo.questionNo ?? "")
                        questionInfo.chosenAns = "D"
                    }, label: {
                        Text("D . \(questionInfo.choiceD ?? "")")
                            .padding(.leading, 20)
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(questionInfo.chosenAns == "D" ? Color.green.opacity(0.3) : Color.clear)
                    })
                }
                .padding(.vertical, 3)
                .font(.title3.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct DropdownView_Previews: PreviewProvider {
    static var previews: some View {
        DropdownView(questionInfo: QuestionInfo(), isOpen: true)
    }
}
