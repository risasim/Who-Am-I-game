//
//  ResultsView.swift
//  WhoAmIGame
//
//  Created by Richard on 08.12.2022.
//

import SwiftUI

struct ResultsView: View {
    
    @Binding var ans: AnswerPack
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navi: Navigator
    
    var body: some View {
        VStack{
            Text("Your score was \(ans.score) from \(ans.index - 1)")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.top)
            List{
                ForEach(ans.answers, id: \.self) { answer in
                    ResultListItemView(answer: answer)
                        .listRowBackground(answer.correct ? Color.green : Color.red)
                }
            }
            .scrollIndicators(.hidden)
            .scrollContentBackground(.hidden)
            Button {
                dismiss()
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
        .navigationTitle("Results")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    navi.path.removeLast(1)
                } label: {
                    HStack{
                        Image(systemName: "chevron.left")
                        Text("Menu")
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
            ResultsView(ans: .constant(AnswerPack(score: 1,index: 3, answers: [Answer(question: "JFK", correct: true), Answer(question: "Richard Nixon", correct: false)]))//, active: .constant(true)
            )
        }
    }
}


struct ResultListItemView: View{
    
    @AppStorage("showLinks")var link = true
    @AppStorage("localLanguage")var selectedLanguage:String = "EN"
    var answer: Answer
    
    var body: some View{
        HStack{
            Text(answer.question)
                .foregroundColor(.accentColor)
            Spacer()
            if link{
                if let que = answer.question.replacingOccurrences(of: " ", with: "_").addingPercentEncoding(withAllowedCharacters: .urlPathAllowed){
                    Link(destination: (URL(string: "https://\(selectedLanguage).wikipedia.org/wiki/\(que)") ?? URL(string: "https://\(selectedLanguage).wikipedia.org"))!) {
                        HStack{
                            Text("Wikipedia")
                            Image(systemName: "arrow.up.right.square")
                        }
                        .font(.footnote)
                    }
                }
            }
        }
    }
}
