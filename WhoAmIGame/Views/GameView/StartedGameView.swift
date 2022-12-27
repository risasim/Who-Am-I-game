//
//  StartedGameView.swift
//  WhoAmIGame
//
//  Created by Richard on 11.12.2022.
//

import SwiftUI

struct StartedGameView: View {
    
    @Binding var text:String
    @Binding var time: Int
    @Binding var color: Color
    
    var body: some View {
        VStack {
            Text(String(time))
                .fontWeight(.bold)
                .font(.title2)
            Spacer()
            Text(text)
                .font(.system(size: 75))
                .fontWeight(.bold)
                .fontDesign(.serif)
                .foregroundColor(color)
            Spacer()
        }
    }
}

struct StartedGameView_Previews: PreviewProvider {
    static var previews: some View {
        StartedGameView(text: .constant("Petr Bezruč"), time: .constant(29), color: .constant(.white))
    }
}
