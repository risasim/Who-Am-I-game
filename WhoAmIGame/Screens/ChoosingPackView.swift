//
//  ChoosingPackView.swift
//  WhoAmIGame
//
//  Created by Richard on 04.12.2022.
//

import SwiftUI
import RealmSwift

struct ChoosingPackView: View {
    
    @ObservedObject private var realmie = RealmGuess()
    @ObservedResults(QuestionPack.self) var questionPacks
    
    
    @State var isSettingsShown:Bool = false
    @State var isNewPackShown: Bool = false
    
    
    var body: some View {
        NavigationStack{
            VStack{
                questionPacks.isEmpty ? AnyView(EmptyPacksView()) : AnyView(ListPackView())
            }
            .sheet(isPresented: $isSettingsShown, content: {
                SettingsView()
            })
            .sheet(isPresented: $isNewPackShown, content: {
                NewPackView(packModel: AddModel(realm: realmie))
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                       isSettingsShown = true
                    } label: {
                        Image(systemName: "gear")
                            .font(.title2)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Who Am I ?")
                        .font(.system(size: 27, weight: .bold, design: .rounded))
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        isNewPackShown = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
            }
        }
    }
}

struct ChoosingPackView_Previews: PreviewProvider {
    static var previews: some View {
        ChoosingPackView()
    }
}
