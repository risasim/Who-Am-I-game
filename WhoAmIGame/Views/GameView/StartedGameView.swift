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
    @Binding var ans: AnswerPack
    @Binding var rans: AnswerPack
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
                .font(.system(size: 110))
                .scaledToFit()
                .minimumScaleFactor(0.01)
                .fontWeight(.bold)
                .fontDesign(.serif)
                .foregroundColor(color)
                .onChange(of: text) { newValue in
                    if newValue == "End of the Game"{
                        ans = rans
                        active =  true
                       // navi.path.append(points)
                    }
                }
            Spacer()
        }
        .persistentSystemOverlays(.hidden)
        .onDisappear {
            feedbackManager.impactOccurred()
        }
      //  .navigationDestination(for: [Answer].self) { nothing in
      //      ResultsView(answers: self.answers, points: self.points)
      //  }
    }
}

struct StartedGameView_Previews: PreviewProvider {
    static var previews: some View {
        StartedGameView(text: .constant("Petr Bezruč"), time: .constant(29), color: .constant(.accentColor), active: .constant(false), ans: .constant(AnswerPack()), rans: .constant(AnswerPack()))
    }
}
