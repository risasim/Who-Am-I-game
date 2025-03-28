//
//  ResultsView.swift
//  WhoAmIGame
//
//  Created by Richard on 08.12.2022.
//

import SwiftUI

struct ResultsView: View {
    
    @Binding var ans: AnswerPack
    @ObservedObject var gameModel:GameModel
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navi: Navigator
    
    var body: some View {
        
        let scored: Bool = !(ans.answers.count == 0)
        
        VStack{
            if scored{
                Text("Your score was \(ans.score) from \(ans.answers.count)")
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
            }else{
                Spacer()
                Text("game.ups")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }
            Button {
                gameModel.checkOrientation()
                dismiss()
            } label: {
                Text("game.playagain")
            }
                .fontWeight(.bold)
                .font(.title2)
                .padding()
                .background(Color.blue)
                .cornerRadius(20)
                .foregroundColor(.white)
                .padding(10)
            //Spacer()
        }
        .multilineTextAlignment(.center)
        .navigationBarBackButtonHidden()
        .navigationTitle("game.res")
        .onAppear(perform: {
            AppDelegate.orientationLock = .all
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    navi.path.removeLast(1)
                } label: {
                    HStack{
                        Image(systemName: "chevron.left")
                        Text("game.menu")
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
            ResultsView(ans: .constant(AnswerPack(score: 1, answers: [Answer(question: "JFK", correct: true), Answer(question: "Richard Nixon", correct: false)])), gameModel: GameModel(pack: RealmQuestionPack())//, active: .constant(true)
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
