//
//  ResultsView.swift
//  WhoAmIGame
//
//  Created by Richard on 08.12.2022.
//

import SwiftUI

struct ResultsView: View {
    
    @Binding var ans: AnswerPack
    @Binding var active: Bool
    
    @EnvironmentObject var navi: Navigator
    
    
    var body: some View {
        VStack {
            Text("Results")
                .font(.system(size: 27, weight: .bold, design: .rounded))
            List{
                ForEach(ans.answers, id: \.self) { answer in
                    Text(answer.question)
                        .font(.title2)
                        .foregroundColor(.white)
                        .listRowBackground(answer.correct ? Color.green : Color.red)
                }
            }
            .scrollContentBackground(.hidden)
            Button {
                active = false
            } label: {
                Text("Play again")
            }
                .fontWeight(.bold)
                .font(.title)
                .padding()
                .background(Color.blue)
                .cornerRadius(40)
                .foregroundColor(.white)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.blue, lineWidth: 5)
                )
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    navi.path.removeLast(1)
                } label: {
                    HStack{
                        Image(systemName: "chevron.left")
                        Text("Back to menu")
                    }
                    .foregroundColor(.blue)
                }
                
            }
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ResultsView(ans: .constant(AnswerPack(score: 4, answers: [Answer(question: "JFK", correct: true), Answer(question: "Richard Nixon", correct: false)])), active: .constant(true))
        }
    }
}
