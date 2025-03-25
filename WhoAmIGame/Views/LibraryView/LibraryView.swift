//
//  LibraryView.swift
//  WhoAmIGame
//
//  Created by Richard on 31.08.2024.
//

import SwiftUI

///View presenting the library of the packs from the PocketBase.
struct LibraryView: View {
    @State var isSettingsShown: Bool = false
    @AppStorage("libraryExplanationShown") var libShown: Bool = false
    var body: some View {
        if(!libShown){
            LibraryOnBoardingView()
        }else{
            NavigationStack{
                ChooseConnectionView()
                    .sheet(isPresented: $isSettingsShown, content: {
                        SettingsView()
                    })
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                isSettingsShown = true
                            } label: {
                                Image(systemName: "gear")
                                    .font(.title2)
                                    .padding(.bottom,0)
                            }
                        }
                        ToolbarItem(placement: .principal) {
                            Text("Who Am I ?")
                                .font(.system(size: 27, weight: .bold, design: .rounded))
                                .padding(.bottom, 0)
                        }
                        
                    }
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    LibraryView()
        .environmentObject(RealmGuess())
        .environmentObject(SavedPacks())
        .environmentObject(PocketBaseHandler())
        .environmentObject(NetworkController())
}
