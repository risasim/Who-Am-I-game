//
//  SharePackToastView.swift
//  WhoAmIGame
//
//  Created by Richard Šimoník on 13.03.2025.
//

import SwiftUI

///View that is presented after pushing the share button informing user about the state of the upload what happens afterwards
struct SharePackToastView: View {
    @EnvironmentObject var pbHandler :PocketBaseHandler
    var body: some View {
        VStack{
            Text(pbHandler.uploadState.getDescription())
        }
        
        .frame(minWidth: 200,minHeight: 200)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 23, style: .continuous)
        )
        .overlay(content: {
            VStack{
                HStack{
                    Spacer()
                    Button{
                        pbHandler.uploadState = .waiting
                    }label: {
                        Image(systemName: "xmark")
                            .padding()
                            .bold()
                            .foregroundColor(.red)
                    }
                }
                Spacer()
            }
        })
#if DEBUG
        .onAppear(perform: pbHandler.showForPreview)
#endif
    }
}

#Preview {
    ZStack{
        ChoosingPackView()
    }
    .environmentObject(RealmGuess())
    .environmentObject(NetworkController())
    .environmentObject(PocketBaseHandler())
}
