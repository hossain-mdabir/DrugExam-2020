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
        VStack {
            HStack {
                Button(action: {
                    withAnimation { self.isOpen.toggle() }
                }, label: {
                    Image(systemName: isOpen ? "chevron.up" : "chevron.down")
                        .font(.title3.weight(.heavy))
                        .foregroundColor(Color.black)
                        .padding(5)
                })
                
                Text("Q1. What is Silofast?")
                    .font(.title3.weight(.bold))
                Spacer()
                Button(action: {
                    withAnimation { self.isStar.toggle() }
                }, label: {
                    Image(systemName: isStar ? "star.fill" : "star")
                        .font(.title3)
                })
            }
            .padding()
//            .frame(minWidth: .infinity)
            .foregroundColor(Color.white)
            .background(Color.black.opacity(0.7))
            .cornerRadius(5)
            .padding(5)
            
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
