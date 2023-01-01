//
//  GameView.swift
//  WhoAmIGame
//
//  Created by Richard on 08.12.2022.
//

import SwiftUI

struct GameView: View {
    
    @ObservedObject var model:GameModel
    
    var body: some View {
        VStack{
            (model.question == "Please turn over your phone to start the game") ? AnyView(TurnOverPhoneView(text: model.question)) : AnyView(StartedGameView(text: $model.question, time: $model.time, color: $model.color))
       
        }
        .navigationDestination(isPresented: $model.ended, destination: {
            // Probably not a valid solution??
            ResultsView(answers: model.answers, points: model.points)
        })
        .onDisappear{
            model.endGame()
        }
        .onAppear{
            model.checkOrientation()
        }
        .onRotate(perform: { newOrientation in
            //may gonna have to change this isnt really valid solution ??
            model.checkOrientation()
        })
        .toolbar(.hidden, for: .tabBar)
        //.navigationBarBackButtonHidden()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(model: GameModel(pack: QuestionPack()))
    }
}


// https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-device-rotation

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
