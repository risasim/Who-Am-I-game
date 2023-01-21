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
    @State var search: String = ""
    @State var change: Bool = false
    
    //@EnvironmentObject var realm: RealmGuess
    
    @State var questionpacks: [QuestionPack]
    
    var body: some View {
        VStack{
            ScrollView {
                LazyVGrid(columns: gridLayout,spacing: 15) {
                    ForEach(questionpacks) { pack in
                        NavigationLink(value: pack) {
                            ListItemView(pack: pack, changed: $change)
                            //.padding()
                        }
                        .onTapGesture {
                            feedbackManager.impactOccurred()
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
        //Actually not working
        .searchable(text: $search,placement: .navigationBarDrawer, prompt: "Search pack...")
    }
}

struct ListPackView_Previews: PreviewProvider {
    static var previews: some View {
        ListPackView(questionpacks: []).environmentObject(RealmGuess())
    }
}
