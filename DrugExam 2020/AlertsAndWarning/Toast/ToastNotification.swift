//
//  ToastTest.swift
//  THP Online
//
//  Created by AM1 on 23/10/22.
//

import SwiftUI

// MARK: - Toast for Order
struct ToastNotification: ViewModifier {
    
    @Binding var isNeedToShow: Bool
    @Binding var message: String
    
    let duration: TimeInterval
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isNeedToShow {
                VStack {
                    Spacer()
                    HStack {
//                        Image("thp_logo")
//                            .resizable()
//                            .frame(width: 20, height: 20)
                        
                        Text(message)
                            .font(.footnote)
                    }
                    .scaledToFit()
                    .padding()
                    .foregroundColor(Color.primary)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(15)
                    .shadow(color: .gray, radius: 2, x: 0, y: 3)
                }
                .padding(.bottom, 80)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        withAnimation {
                            isNeedToShow = false
                        }
                    }
                }
            }
        }
    }
}

//MARK: - Order Toast Duration Extension
extension View {
    func toastNotification(isNeedToShow: Binding<Bool>, msg: Binding<String>, duration: TimeInterval = 3) -> some View {
        modifier(ToastNotification(isNeedToShow: isNeedToShow, message: msg, duration: duration))
    }
}
