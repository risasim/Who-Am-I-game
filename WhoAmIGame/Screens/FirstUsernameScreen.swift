//
//  FirstUsernameScreen.swift
//  WhoAmIGame
//
//  Created by Richard on 05.12.2022.
//

import SwiftUI

struct FirstUsernameScreen: View {
    @AppStorage("isFirstTime") var isFirstTime : Bool?
    @AppStorage ("username") var username: String = ""
    var body: some View {
        VStack(alignment: .center){
            Text("""
Please enter username.
Username will be used for publishing your own packs
""")
                .font(.title3)
                .fontWeight(.semibold)
            TextField("Enter here", text: $username)
                .padding(.all, 6)
                .background(
                    Color(.gray).opacity(0.1)
                        .cornerRadius(5)
                )
                .onSubmit {
                    isFirstTime = false
                    print(username)
                }
            Button {
                isFirstTime = false
            } label: {
                Text("Submit username")
                    .foregroundColor(.white)
            }
            .padding(.all, 10)
            .background(
                Color("CheckColor")
                    .cornerRadius(10)
            )
            .padding(.top , 40)

        }
        .padding(.horizontal)
        .multilineTextAlignment(.center)
    }
}

struct FirstUsernameScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirstUsernameScreen()
    }
}
