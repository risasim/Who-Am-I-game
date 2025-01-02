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
                ChoosingPackView()
                //.environmentObject(router)
                    .tabItem{
                        Label("tab.Packs", systemImage: "square.stack.3d.down.right")
                    }
               LibraryView()
                    .tabItem {
                        Label("Library", systemImage: "magnifyingglass")
                    }
            }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
