//
//  ChooseConnectionView.swift
//  WhoAmIGame
//
//  Created by Richard Šimoník on 02.01.2025.
//

import SwiftUI

///View in library, that decides what UI to show depending on the network connection.
struct ChooseConnectionView: View {
    @ObservedObject var network = NetworkController()
    var body: some View {
        if network.isConnected{
            ConnectedView()
        }else{
            NotConnectedView(network: network)
        }
    }
}

#Preview {
    ChooseConnectionView()
        .environmentObject(RealmGuess())
}
