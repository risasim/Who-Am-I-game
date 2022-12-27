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
