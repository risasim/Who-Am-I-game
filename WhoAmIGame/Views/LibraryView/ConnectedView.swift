//
//  ConnectedView.swift
//  WhoAmIGame
//
//  Created by Richard on 31.08.2024.
//

import SwiftUI

///View that is shown, if the app is connected to internet. Shows the packs that could be saved.
struct ConnectedView: View {
    
    @State var packs:[NormalQuestionPack] = []
    @EnvironmentObject var handler:PocketBaseHandler
    @State var showMessage:String = ""
    
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
                handler.fetchPacks{ packs,err in
                    if let packs = packs{
                        self.packs = packs
                    }
                    if let err = err{
                        showMessage = err
                    }
                }
            }
        }
        .refreshable {
            handler.fetchPacks{ packs,err in
                if let packs = packs{
                    self.packs = packs
                }
                if let err = err{
                    showMessage = err
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ConnectedView()
        .environmentObject(PocketBaseHandler())
        .environmentObject(SavedPacks())
}
