//
//  ResultsView.swift
//  WhoAmIGame
//
//  Created by Richard on 08.12.2022.
//

import SwiftUI

struct ResultsView: View {
    
    @ObservedObject var model: GameModel
    
    var body: some View {
        
        VStack {
            Text("Results")
                .font(.system(size: 27, weight: .bold, design: .rounded))
            List{
                ForEach(0..<model.answers.count) { index in
                    Text(model.answers[index])
                        .background(RoundedRectangle(cornerRadius: 10))
                        .listRowBackground(model.correct[index] ? Color.green : Color.red)
                }
            }
            .listStyle(.plain)
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(model: GameModel(pack: QuestionPack()))
    }
}
