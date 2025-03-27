//
//  WhatsNewView.swift
//  WhoAmIGame
//
//  Created by Richard Šimoník on 03.03.2025.
//

import SwiftUI

struct WhatsNewView: View {
    @AppStorage("whatsNewVersion") var version = 0
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Text("whatsnew.title")
                    .bold()
                    .font(.title2)
                Text("whatsnew.text")
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.regularMaterial)
        .ignoresSafeArea()
    }
}

#Preview {
    TabsView()
        .environmentObject(RealmGuess())
        .environmentObject(SavedPacks())
        .overlay {
            WhatsNewView()
        }
}
