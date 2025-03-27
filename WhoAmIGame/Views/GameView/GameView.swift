//
//  GameView.swift
//  WhoAmIGame
//
//  Created by Richard on 08.12.2022.
//

import SwiftUI

struct GameView: View {
    
    @ObservedObject var model:GameModel
   // @State var isActive = false
    @State var banswers: AnswerPack = AnswerPack()
    @State var isPresented: Bool = false
    @State var change: Bool = false

    private let rotationChangePublisher = NotificationCenter.default
        .publisher(for: UIDevice.orientationDidChangeNotification)
    
    @EnvironmentObject var navi: Navigator
    
    var body: some View {
        VStack{
      //      !model.landscape ? AnyView(TurnOverPhoneView()) : AnyView(StartedGameView(text: $model.question, time: $model.time, color: $model.color, active: self.$isPresented, ans: $banswers, rans: $model.answers))
            if !model.gameStarted && !model.landscape{
                TurnOverPhoneView()
                    .onAppear(perform: {
                        print("started = \(model.gameStarted) , landscape = \(model.landscape), overall \(!model.landscape && !model.gameStarted)")
                    })
            }else{
                StartedGameView(text: $model.question, time: $model.time, color: $model.color, active: self.$isPresented, ans: $banswers, rans: $model.answers)
            }
       
        }
        //isPresented binded to StartedGameView to wait for str Game end
        .navigationDestination(isPresented: self.$isPresented, destination: {
            ResultsView(ans: $banswers, gameModel: model// active: $navi.isAcitve
            )
        })
        .onDisappear{
            if isPresented{
                model.endGame()
                feedbackManager.impactOccurred()
            }
            AppDelegate.orientationLock = .all
        }
        .onAppear{
            model.checkOrientation()
        }
        .onReceive(rotationChangePublisher) { _ in
            model.checkOrientation()
        }
        .onChange(of: model.landscape, perform: { newValue in
            change.toggle()
        })
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(!(model.question == "game.TurnOver"))
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(model: GameModel(pack: RealmQuestionPack()))
    }
}

