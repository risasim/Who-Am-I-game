//
//  LibraryView.swift
//  WhoAmIGame
//
//  Created by Richard on 31.08.2024.
//

import SwiftUI

struct LibraryView: View {
    
    @ObservedObject var network = NetworkController()
    
    var body: some View {
        NavigationStack{
            if network.isConnected{
                ConnectedView()
            }else{
                NotConnectedView(network: network)
            }
        }
    }
}

#Preview {
    LibraryView()
}
