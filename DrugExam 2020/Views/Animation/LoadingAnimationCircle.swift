//
//  LoadingAnimationCircle.swift
//  THP Online
//
//  Created by Md Abir Hossain on 20/9/22.
//

import SwiftUI

struct LoadingAnimationCircle: View {
    
    //Loading Animation
    @State private var isloadingAnimation: Bool = false
    
    var body: some View {
        
        //Loading Animation
        VStack {
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(AngularGradient(gradient: .init(colors: [Color("NavBar"), Color("NavBar").opacity(0.5)]), center: .center), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .frame(width: 45, height: 45)
                .rotationEffect(.init(degrees: self.isloadingAnimation ? 360 : 0))
                .animation(Animation.linear(duration: 0.5).repeatForever(autoreverses: false), value: isloadingAnimation)
        }
        .onAppear{
            self.isloadingAnimation.toggle()
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingAnimationCircle()
    }
}
