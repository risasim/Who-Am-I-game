//
//  NotConnectedView.swift
//  WhoAmIGame
//
//  Created by Richard on 31.08.2024.
//

import SwiftUI

///View that is shown if the app is not connected to internet.
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
