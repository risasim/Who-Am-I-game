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
    @State var toastState:PocketBaseState
    var body: some View {
        VStack{
            Text(LocalizedStringResource(stringLiteral: pbHandler.uploadState.getDescription()))
                .font(.title2)
                .bold()
            if(pbHandler.uploadState == .uploading){
                ProgressView()
            }else{
                Image(systemName: pbHandler.uploadState.getIcon())
                    .foregroundStyle(pbHandler.uploadState.getColor())
                    .padding()
                    .font(.custom("Arial", size: 40, relativeTo: .body))
            }
            if(pbHandler.uploadState == .uploaded){
                Text(LocalizedStringResource("library.waitForApproval"))
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .frame(minWidth: 300,minHeight: 300)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 23, style: .continuous)
        )
        .overlay(content: {
            VStack{
                HStack{
                    Spacer()
                    Button{
                        withAnimation {
                            pbHandler.uploadState = .waiting
                        }
                    }label: {
                        Image(systemName: "xmark")
                            .padding()
                            .font(.title2)
                            .bold()
                            .foregroundColor(.red)
                    }
                }
                Spacer()
            }
        })
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
