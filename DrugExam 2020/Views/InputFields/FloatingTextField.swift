//
//  FloatingTextField.swift
//  THP SR
//
//  Created by AM1 on 18/12/22.
//

import SwiftUI

struct FloatingTextField: View {
    
    var title: String
    @Binding var text: String
    
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
                
                // Reusable
                TextField("", text: $text)
                    .padding(.leading, 10)
                    .accentColor(.blue)
                
            }
        }
        .padding(.top, 20)
        .animation(.default, value: text.isEmpty)
        
    }
}

struct FloatingTextField_Previews: PreviewProvider {
    
    @State static var title = ""
    @State static private var text: String = ""
    
    static var previews: some View {
        FloatingTextField(title: title, text: $text)
    }
}
