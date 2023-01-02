//
//  ResultsView.swift
//  WhoAmIGame
//
//  Created by Richard on 08.12.2022.
//

import SwiftUI

struct ResultsView: View {
    
    @Binding var ans: AnswerPack
    
    @EnvironmentObject var navi: Navigator

    
    var body: some View {
        VStack {
            Text("Results")
                .font(.system(size: 27, weight: .bold, design: .rounded))
            List{
                ForEach(ans.answers, id: \.self) { answer in
                    Text(answer.question)
                       // .background(RoundedRectangle(cornerRadius: 10))
                       // .listRowBackground(answer.correct ? Color.green : Color.red)
                }
            }
            Button {
                navi.path.removeLast(1)
            } label: {
                Text("Back to menu")
            }
            .listStyle(.plain)
            .onAppear {
                print(ans)
            }
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(ans: .constant(AnswerPack()))
    }
}
