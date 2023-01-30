//
//  HelloWorldView.swift
//  WhoAmIGame
//
//  Created by Richard on 25.01.2023.
//

import SwiftUI

struct HelloWorldView: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .foregroundColor(.blue)
                .font(.largeTitle)
                .fontWeight(.bold)
            Image("earthPhoto")
                .resizable()
                .scaledToFit()
                .cornerRadius(30)
                .frame(width: 400, height: 400)
        }
    }
}

struct HelloWorldView_Previews: PreviewProvider {
    static var previews: some View {
        HelloWorldView()
    }
}
