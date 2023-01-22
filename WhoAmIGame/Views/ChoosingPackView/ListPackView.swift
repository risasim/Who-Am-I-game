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
    
    @ObservedResults(QuestionPack.self) var questionPacks
    @State var filteredResults:[QuestionPack] = []
    var body: some View {
        VStack{
            ScrollView {
                LazyVGrid(columns: gridLayout,spacing: 15) {
                    ForEach(filteredResults) { pack in
                        NavigationLink(value: pack) {
                            ListItemView(pack: pack, changed: $change)
                            //.padding()
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
        .searchable(text: $search,placement: .automatic, prompt: "Search pack...")
        .onAppear {
            filterResults()
        }
        .onChange(of: search) { newValue in
            filterResults()
        }
        //When deleting to rearrange the List
        .onChange(of: change) { newValue in
            filterResults()
        }
        
    }
    
    func filterResults(){
        if search.isEmpty{
            filteredResults = Array(questionPacks)
        }else{
            filteredResults = questionPacks.filter({ pack in
                pack.name
                    .localizedCaseInsensitiveContains(search)
            })
        }
    }
}

struct ListPackView_Previews: PreviewProvider {
    static var previews: some View {
        ListPackView().environmentObject(RealmGuess())
    }
}
