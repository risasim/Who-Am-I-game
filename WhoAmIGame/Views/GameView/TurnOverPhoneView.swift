//
//  TurnOverPhoneView.swift
//  WhoAmIGame
//
//  Created by Richard on 11.12.2022.
//

import SwiftUI

struct TurnOverPhoneView: View {
    
   @State var text:String
    
    var body: some View {
        VStack{
            ZStack {
                Image(uiImage: UIImage(imageLiteralResourceName: "vectorrotate")
                      .withHorizontallyFlippedOrientation()
                  )
                    .resizable()
                    .scaledToFit()
            }
            Text(text)
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
        }
    }
}

struct TurnOverPhoneView_Previews: PreviewProvider {
    static var previews: some View {
        TurnOverPhoneView(text: "Please turn over your phone to start the game")
    }
}
