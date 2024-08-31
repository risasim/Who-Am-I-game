//
//  LaunchingView.swift
//  WhoAmIGame
//
//  Created by Richard on 18.02.2023.
//

import SwiftUI

///View that is supposed to show when the app is booting
///
///-Warning:
///This view isnt used in the app
struct LaunchingView: View {
    
    @State var animation = false
    
    var body: some View {
        
        ZStack{
            Color.black
                .ignoresSafeArea()
            Image("logo2")
                .resizable()
                .interpolation(.high)
                .scaledToFit()
                .scaleEffect(animation ? 1.0 : 0.6)
        }
        .onAppear{
            withAnimation(.easeOut(duration: 0.8)) {
                animation = true
            }
        }
    }
}

struct LaunchingView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchingView()
    }
}
