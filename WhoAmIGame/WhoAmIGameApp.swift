//
//  WhoAmIGameApp.swift
//  WhoAmIGame
//
//  Created by Richard on 04.12.2022.
//

import SwiftUI

@main
struct WhoAmIGameApp: App {
    @AppStorage("isFirstTime") var isFirstTime = true
    var body: some Scene {
        WindowGroup {
            if isFirstTime == true{
                FirstUsernameScreen()
            }else{
                TabsView()
            }
        }
    }
}


//https://medium.com/@realhouseofcode/swiftui-dismiss-keyboard-on-outside-tap-d3d56894813
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
