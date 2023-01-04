//
//  ResultsView.swift
//  WhoAmIGame
//
//  Created by Richard on 08.12.2022.
//

import SwiftUI

struct ResultsView: View {
    
    @Binding var ans: AnswerPack
   // @Binding var active: Bool
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navi: Navigator
    
    
    var body: some View {
        VStack{
            Text("Results")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.bold)
            List{
                ForEach(ans.answers, id: \.self) { answer in
                    Text(answer.question)
                        .foregroundColor(.white)
                        .listRowBackground(answer.correct ? Color.green : Color.red)
                }
            }
            .scrollContentBackground(.hidden)
            Button {
                dismiss()
               // navi.isAcitve = false
            } label: {
                Text("Play again")
            }
                .fontWeight(.bold)
                .font(.title2)
                .padding()
                .background(Color.blue)
                .cornerRadius(20)
                .foregroundColor(.white)
                .padding(10)
            Spacer()
        }
        .multilineTextAlignment(.center)
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
                    .font(.headline)
                    .foregroundColor(.blue)
                }
                
            }
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ResultsView(ans: .constant(AnswerPack(score: 4, answers: [Answer(question: "JFK", correct: true), Answer(question: "Richard Nixon", correct: false)]))//, active: .constant(true)
            )
        }
    }
}
