//
//  ChoosingPackView.swift
//  WhoAmIGame
//
//  Created by Richard on 04.12.2022.
//

import SwiftUI
import RealmSwift

struct ChoosingPackView: View {
    
    @ObservedObject var realm = RealmGuess()
    
    
    @State var isSettingsShown:Bool = false
    @State var isNewPackShown: Bool = false
    @State var favourites:Bool = false
    @State var outerChange: Bool = false 
    
    @ObservedObject var navi = Navigator()
    
    var body: some View {
        NavigationStack(path: $navi.path){
            VStack{
                realm.questionPacks.isEmpty ? AnyView(EmptyPacksView()) : AnyView(ListPackView(favourites: $favourites, outerChange: $outerChange).environmentObject(realm))
            }
            .overlay(content: {
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        PlusButtonView(variable: $isNewPackShown)
                    }
                }
            })
            .sheet(isPresented: $isSettingsShown, content: {
                SettingsView()
            })
            .sheet(isPresented: $isNewPackShown, content: {
                NewPackView(packModel: EditAddModel(realm: realm))
                    .onDisappear {
                        outerChange.toggle()
                    }
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
                        favourites.toggle()
                    } label: {
                        Image(systemName: "list.star")
                            .font(.title2)
                    }
                }
            }
        }
        .environmentObject(realm)
        .environmentObject(navi)
        .onTapGesture(count: 2, perform: {
                self.hideKeyboard()
        })
        .onAppear(perform: {
            AppDelegate.orientationLock = .all
        })
    }
}

struct ChoosingPackView_Previews: PreviewProvider {
    static var previews: some View {
        ChoosingPackView()
    }
}
