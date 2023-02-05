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
    @Binding var favourites:Bool
    @State var change: Bool = false
    @State var noFavourites = false
    
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
            .scrollIndicators(.hidden)
        }
        .overlay(content: {
            if noFavourites{
                NoFavView()
            }
        })
        .searchable(text: $search,placement: .navigationBarDrawer, prompt: "Search pack...")
        .onAppear {
            filterResults()
        }
        .onChange(of: search) { newValue in
            filterResults()
        }
        .onChange(of: favourites, perform: { newValue in
            getFavs()
            if newValue == false{
                noFavourites = false
            }
        })
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
    func getFavs(){
        if favourites{
            var favPacks: [QuestionPack] = []
            for pack in questionPacks{
                if pack.isFavourite{
                    favPacks.append(pack)
                }
            }
            if favPacks.isEmpty{
                noFavourites = true
            }
            filteredResults = favPacks
        }else{
            filteredResults = Array(questionPacks)
        }
    }
}

struct ListPackView_Previews: PreviewProvider {
    static var previews: some View {
        ListPackView(favourites: .constant(false)).environmentObject(RealmGuess())
    }
}
