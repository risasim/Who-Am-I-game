//
//  TabView.swift
//  WhoAmIGame
//
//  Created by Richard on 27.12.2022.
//

import SwiftUI

struct TabsView: View {
    @State private var selectedTab: Int = 1
    var body: some View {
        VStack{
            TabView(selection: $selectedTab) {
                MainPacksView()
                    .tabItem{
                        Label("tab.Packs", systemImage: "square.stack.3d.down.right")
                    }
                    .tag(1)
                LibraryView()
                    .tabItem {
                        Label("tab.Icon.Library", systemImage: "books.vertical.fill")
                    }
                    .tag(2)
            }
        }
        .onOpenURL { incomingURL in
            print("App was opened via URL: \(incomingURL)")
            handleIncomingURL(incomingURL)
        }
    }
    /// Handles the incoming URL and performs validations before acknowledging.
    private func handleIncomingURL(_ url: URL) {
        guard url.scheme == "risasimonikwhoamipartygame" else {
            return
        }
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            print("Invalid URL")
            return
        }
        guard let action = components.host, action == "open-library" else {
            print("Unknown URL, we can't handle this one!")
            return
        }
        selectedTab=2
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
