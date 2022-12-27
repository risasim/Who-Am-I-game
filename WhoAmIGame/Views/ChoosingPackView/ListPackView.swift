//
//  ListPackView.swift
//  WhoAmIGame
//
//  Created by Richard on 04.12.2022.
//

import SwiftUI
import RealmSwift

struct ListPackView: View {
    
    @State var navPath = NavigationPath()
    let feedback = UIImpactFeedbackGenerator(style: .medium)
    
    @ObservedObject private var realmie = RealmGuess()
    @ObservedResults(QuestionPack.self) var questionPacks
    
    var body: some View {
        VStack{
            ScrollView {
                LazyVGrid(columns: gridLayout,spacing: 15) {
                    ForEach(questionPacks) { pack in
                        NavigationLink(value: pack) {
                            ListItemView(pack: pack)
                                //.padding()
                        }
                            .onTapGesture {
                                feedback.impactOccurred()
                                withAnimation(.easeOut) {
                                   //
                                }
                            }
                    }
                }
                .navigationDestination(for: QuestionPack.self, destination: { pack in
                    GameView(model: GameModel(pack: pack))
                })
            .padding()
            }
        }

    }
}

struct ListPackView_Previews: PreviewProvider {
    static var previews: some View {
        ListPackView()
    }
}
