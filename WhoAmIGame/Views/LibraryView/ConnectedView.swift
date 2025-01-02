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
        List(packs,id: \.name){pack in
            Text(pack.name)
        }
        .onAppear{
            handler.fetchPacks{ packs in
                self.packs = packs
            }
        }
    }
}

#Preview {
    ConnectedView()
}
