//
//  NoFavView.swift
//  WhoAmIGame
//
//  Created by Richard on 04.02.2023.
//

import SwiftUI

struct NoFavView: View {
    var body: some View {
        VStack {
            Text("pack.noFavPacks")
                .multilineTextAlignment(.center)
                .font(.title3)
                .fontWeight(.semibold)
            Image("heart")
                .resizable()
                .interpolation(.high)
                .scaledToFit()
                .frame(height: 40)
        }
    }
}

struct NoFavView_Previews: PreviewProvider {
    static var previews: some View {
        NoFavView()
    }
}
