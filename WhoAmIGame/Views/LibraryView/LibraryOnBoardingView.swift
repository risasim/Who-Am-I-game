//
//  LibraryOnBoardingView.swift
//  WhoAmIGame
//
//  Created by Richard Šimoník on 05.01.2025.
//

import SwiftUI

///View that is shown when the user first enters the library
struct LibraryOnBoardingView: View {
    @AppStorage("libraryExplanationShown") var libShown: Bool = false
    var body: some View {
        VStack{
            Spacer()
            Text("library.welcome")
                .font(.title)
                .padding(.bottom,60)
                .bold()
            Text("library.explanation")
                .padding()
                .multilineTextAlignment(.center)
                .font(.title3)
            Spacer()
            Button{
                libShown.toggle()
            }label:{
                Label("library.enter", systemImage: "chevron.right")
                    .font(.title3)
            }
            .buttonStyle(.bordered)
            .padding(.bottom,50)
        }
    }
}

#Preview {
    LibraryOnBoardingView()
}
