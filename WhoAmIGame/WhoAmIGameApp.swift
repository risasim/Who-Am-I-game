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
    @AppStorage("wasUploaded") var upload = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject var realm = RealmGuess()
    @ObservedObject var network = NetworkController()
    @State var saved = SavedPacks()
    @StateObject var pbHandler = PocketBaseHandler()
    
    var body: some Scene {
        WindowGroup {
            if isFirstTime == true{
                FirstUsernameScreen()
                    .onAppear {
                        if !upload{
                            StartingDatabase(realm: realm)
                            upload = true
                        }
                    }
            }else{
                TabsView()
                    .environmentObject(realm)
                    .environmentObject(saved)
                    .environmentObject(pbHandler)
                    .environmentObject(network)
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate{
    static var orientationLock = UIInterfaceOrientationMask.all
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
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
