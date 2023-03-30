//
//  FloatingSecureTextField.swift
//  THP SR
//
//  Created by AM1 on 18/12/22.
//

import SwiftUI

struct FloatingSecureTextField: View {
    
    var title: String
    @Binding var text: String
    @State var isSecure: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            Text("\(title)")
                .padding(.leading, 10)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(text.isEmpty ? Color(.gray).opacity(0.5) : .gray)
                .offset(y: text.isEmpty ? 0 : -30)
                .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .leading)
            
            
            HStack {
                
                if isSecure {
                    SecureField("", text: $text)
                        .padding(.leading, 10)
                        .accentColor(.blue)
                } else {
                    // Reusable
                    TextField("", text: $text)
                    .padding(.leading, 10)
                    .accentColor(.blue)
                }
                
                Spacer()
                Button(action: {
                    
                    withAnimation{ self.isSecure.toggle() }
                    
                }) {
                    if isSecure {
                        Image(systemName: "eye.slash.fill")
                            .font(Font.body.bold())
                            .foregroundColor(Color.primary.opacity(0.7))
                    } else {
                        Image(systemName: "eye.fill")
                            .font(Font.body.bold())
                            .foregroundColor(Color.primary.opacity(0.7))
                    }
                }
            }
        }
        .padding(.top, 20)
        .animation(.default, value: text.isEmpty)
        
    }
}

struct FloatingSecureTextField_Previews: PreviewProvider {
    
    @State static var title = ""
    @State static private var text: String = ""
    @State static private var isSecure: Bool = false
    
    static var previews: some View {
        FloatingSecureTextField(title: title, text: $text, isSecure: isSecure)
    }
}
