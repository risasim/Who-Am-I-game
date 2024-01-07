//
//  TurnOverPhoneView.swift
//  WhoAmIGame
//
//  Created by Richard on 11.12.2022.
//

import SwiftUI

struct TurnOverPhoneView: View {
    
    var body: some View {
        VStack{
            ZStack {
               // Image(uiImage: UIImage(imageLiteralResourceName: "vectorrotate")
               //       .withHorizontallyFlippedOrientation()
               //   )
                Image("vectorrotate")
                    .resizable()
                    .scaledToFit()
            }
            Text("game.TurnOver")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
        }
    }
}

struct TurnOverPhoneView_Previews: PreviewProvider {
    static var previews: some View {
        TurnOverPhoneView()
    }
}
