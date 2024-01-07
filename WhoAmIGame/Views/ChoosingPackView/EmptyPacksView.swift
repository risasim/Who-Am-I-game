//
//  EmptyPacksView.swift
//  WhoAmIGame
//
//  Created by Richard on 04.12.2022.
//

import SwiftUI

struct EmptyPacksView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("emptyPackText")
            .multilineTextAlignment(.center)
            .font(.title3)
            .fontWeight(.semibold)
            HStack{
                Spacer()
            }
            Spacer()
        }
    }
}

struct EmptyPacksView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyPacksView()
    }
}
