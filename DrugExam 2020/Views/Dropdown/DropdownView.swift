//
//  DropdownView.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 31/3/23.
//

import SwiftUI

struct DropdownView: View {
    
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
                    
                    Text("Q1. What is Silofast?")
                        .font(.title3.weight(.semibold))
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
                VStack(alignment: .leading) {
                    Text("A . Preparation of Dutasteride")
                    Text("B . Preparation of Tamsulosin")
                    Text("C . Preparation of Silodosin")
                    Text("D . Both A & B")
                }
                .font(.title3.weight(.semibold))
            }
        }
    }
}

struct DropdownView_Previews: PreviewProvider {
    static var previews: some View {
        DropdownView(isOpen: true, isStar: true)
    }
}
