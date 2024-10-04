//
//  NotConnectedView.swift
//  WhoAmIGame
//
//  Created by Richard on 31.08.2024.
//

import SwiftUI

struct NotConnectedView: View {
    
    var network: NetworkController
    
    var body: some View {
        VStack{
            Image(systemName: "wifi.slash")
                .font(.largeTitle)
                .padding(.bottom, 10)
            Text("No connection")
                .font(.title2)
        }
        .bold()
    }
}

#Preview {
    NotConnectedView(network: NetworkController())
}