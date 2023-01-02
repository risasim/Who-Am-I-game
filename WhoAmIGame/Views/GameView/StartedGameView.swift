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
    @Binding var active: Bool
    //@Binding var ended: 
    
   // @Binding var answers: [Answer]
   // @Binding var points: Int
    
    @EnvironmentObject var navi : Navigator
    
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
                .onChange(of: text) { newValue in
                    if newValue == "End of the Game"{
                        active =  true
                       // navi.path.append(points)
                    }
                }
            Spacer()
        }
      //  .navigationDestination(for: [Answer].self) { nothing in
      //      ResultsView(answers: self.answers, points: self.points)
      //  }
    }
}

struct StartedGameView_Previews: PreviewProvider {
    static var previews: some View {
        StartedGameView(text: .constant("Petr Bezruč"), time: .constant(29), color: .constant(.white), active: .constant(false))
    }
}
