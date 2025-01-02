//
//  ConnectedView.swift
//  WhoAmIGame
//
//  Created by Richard on 31.08.2024.
//

import SwiftUI

struct ConnectedView: View {
    
    var handler = PocketBaseHandler()
    @State var packs:[NormalQuestionPack] = []
    
    var body: some View {
        VStack{
            ScrollView {
                LazyVGrid(columns: gridLayout,spacing: 15) {
                    ForEach(packs, id: \.name) { pack in
                        LibraryPackView(pack: pack)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .onAppear{
                handler.fetchPacks{ packs in
                    self.packs = packs
                }
            }
        }
        .padding()
    }
}

#Preview {
    ConnectedView()
}
