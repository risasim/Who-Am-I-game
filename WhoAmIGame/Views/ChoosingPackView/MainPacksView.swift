//
//  MainPacksView.swift
//  WhoAmIGame
//
//  Created by Richard Šimoník on 15.03.2025.
//

import SwiftUI

struct MainPacksView: View {
    @EnvironmentObject var pbHandler:PocketBaseHandler
    var body: some View {
        ZStack {
            ChoosingPackView()
            if(pbHandler.uploadState != .waiting){
                SharePackToastView()
            }
        }
    }
}

#Preview {
    MainPacksView()
        .environmentObject(RealmGuess())
        .environmentObject(SavedPacks())
        .environmentObject(PocketBaseHandler())
}
