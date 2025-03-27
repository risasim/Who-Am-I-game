//
//  TabView.swift
//  WhoAmIGame
//
//  Created by Richard on 27.12.2022.
//

import SwiftUI

struct TabsView: View {
    var body: some View {
        VStack{
            TabView {
                MainPacksView()
                    .tabItem{
                        Label("tab.Packs", systemImage: "square.stack.3d.down.right")
                    }
                LibraryView()
                    .tabItem {
                        Label("tab.Icon.Library", systemImage: "books.vertical.fill")
                    }
            }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
            .environmentObject(RealmGuess())
            .environmentObject(SavedPacks())
            .environmentObject(PocketBaseHandler())
            .environment(\.locale, .init(identifier: "zh-Hans"))
    }
}
