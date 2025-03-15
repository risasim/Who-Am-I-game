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
                getPacks()
            }
        }
        .refreshable {
            getPacks()
        }
        .padding(.horizontal)
    }
    
    private func getPacks(){
        handler.fetchPacks{ packs,err in
            if let packs = packs{
                DispatchQueue.main.async {
                    self.packs = packs
                }
            }
            if let err = err{
                DispatchQueue.main.async {
                    showMessage = err
                }
            }
        }
    }
}

#Preview {
    ConnectedView()
        .environmentObject(PocketBaseHandler())
        .environmentObject(SavedPacks())
}
