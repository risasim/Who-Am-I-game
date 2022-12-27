//
//  GameModel.swift
//  WhoAmIGame
//
//  Created by Richard on 04.12.2022.
//

import Foundation
import CoreMotion
import SwiftUI
import UIKit


final class GameModel: ObservableObject{
    @AppStorage("gameTime") var countTime: Int = 30
    
    @Published var question = ""
    @Published var time:Int = 0
    @Published var started = false
    @Published var color: Color = .white
    
    private var ended:Bool = false
    
    private var readyPack : [Question]
    private var index = 0
    
    //Models
    private let motionManager = CMMotionManager()
    private let queue = OperationQueue()
    private let debouncer = Debouncer(timeInterval: 0.7)
    
    //Orientation
    private var pitch: Double = 0
    private var roll: Double = 0
    private var yaw : Double = 0
    
    private var orientation = UIDevice.current.orientation
    
    private var timer: Timer!
    
    //Final
    @Published var answers: [String:Bool] = [:]
    @Published var points: Int = 0
    
    
    init(pack: QuestionPack){
        self.readyPack = pack.names.shuffled()
        checkOrientation()
    }
    
    
    //checking if phone is in right orientation -> start game
    func checkOrientation(){
        orientation = UIDevice.current.orientation
        if !started{
            if !orientation.isLandscape{
                question = "Please turn over your phone to start the game"
            }else{
                print("go through")
                started = true
                startGame()
            }
        }
    }
    
    func startGame(){
        //start telemetry
        self.motionManager.startDeviceMotionUpdates(to: self.queue) { (data: CMDeviceMotion?, error: Error?) in
            guard let data = data else {
                print("Error: \(error!)")
                return
            }
            
            let attitude: CMAttitude = data.attitude
            
            print("pitch: \(attitude.pitch)")
            print("yaw: \(attitude.yaw)")
            print("roll: \(attitude.roll)")
            
            DispatchQueue.main.async {
                self.pitch = attitude.pitch
                self.yaw = attitude.yaw
                self.roll = attitude.roll
                
                self.waitingForMotion(self.pitch, self.yaw, self.roll)
            }
        }
        getQuestion()
        startTimer()
    }
    
    func waitingForMotion(_ pitch: Double, _ yaw:  Double, _ attitude: Double){
        if (roll > 0.9 && -0.5 ... 0.7 ~= pitch){
            //maybe to delete was before the orieantation trick
            //probably vital for understating the orientation of the phone (left or right landscape!!)
            if 2.11...2.14 ~= roll{
                //change index
                //if questionPack.names.count > index{
                // Changing color red and after 0.6 s back to black
                self.color = .green
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(700) ){
                    self.color = .white
                }
                debouncer.renewInterval()
                debouncer.handler = {
                    //RESOLVE TO CHANGE IMMEDEIATELY AFTER SWING????
                    self.rightAnswer()
                }
            }
        }else{
            //was when user wasn having phone in wanted orienataiton
        }
    }
    
    func startTimer(){
        time = countTime
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.refreshValue), userInfo: nil, repeats: true)
    }
    @objc func refreshValue(){
        time -= 1
        //print(time)
        if  time <= 0{
            self.timer.invalidate()
            endGame()
        }
    }
    
    //if you can still get question get other question, else end the game
    func getQuestion(){
        if index < readyPack.count{
            question = readyPack[index].name
        }else{
            endGame()
        }
    }
    func rightAnswer(){
        index += 1
        points += 1
        answers[self.question] = true
        getQuestion()
    }
    
    func wrongAnswer(){
        index += 1
        answers[self.question] = false
        getQuestion()
    }
    
    func endGame(){
        self.question = "End of the Game"
        //end telemetry
        self.motionManager.stopDeviceMotionUpdates()
        // export points and answers
        //push new view!!!!!!!!!!!!!!!
        self.points = 0
        self.index = 0
        self.answers = [:]
        
    }
    
}





//   func checkMotion(){
//
//       self.motionManager.startDeviceMotionUpdates(to: self.queue) { (data: CMDeviceMotion?, error: Error?) in
//           guard let data = data else {
//               print("Error: \(error!)")
//               return
//           }
//           let attitude: CMAttitude = data.attitude
//
//           print("pitch: \(attitude.pitch)")
//           print("yaw: \(attitude.yaw)")
//           print("roll: \(attitude.roll)")
//
//           DispatchQueue.main.async {
//
//               showResults = gameTimer(on: timeDuration)
//
//              // waitingForMotion()
//
//               self.pitch = attitude.pitch
//               self.yaw = attitude.yaw
//               self.roll = attitude.roll
//           }
//       }
//   }
//
//   func waitingForMotion(){
//
//       if (roll > 0.9 && -0.5 ... 0.7 ~= pitch){
//           text = "Start a game "
//
//           if 2.11...2.14 ~= roll{
//               if questionPack.names.count > i.i{
//                   debouncer.renewInterval()
//                   debouncer.handler = {
//                       i.increment()
//                   }
//               }else{
//
//               }
//               // Changing color red and after 0.6 s back to black
//               color = .red
//               DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(600) ){
//                   color = .black
//
//               }
//           }
//       }else{
//           text = ""
//       }
//   }
//
//   func gameTimer(on time: Int) -> Bool{
//       var ended : Bool = false
//
//       DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(time)){
//         ended = true
//       }
//
//       return ended ? true : false
//   }
//   }
//
//


// DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(timeDuration)){
//     showResults.toggle()
// }
// var currentPack = pack
// var receivedPack = getQuestion(from: currentPack)
// guard let cardie = receivedPack.0?.name else{
//     fatalError("Cannot get the question")
// }
// currentPack = receivedPack.1
// card = cardie
//
// self.motionManager.startDeviceMotionUpdates(to: self.queue) { (data: CMDeviceMotion?, error: Error?) in
//     guard let data = data else {
//         print("Error: \(error!)")
//         return
//     }
//     let attitude: CMAttitude = data.attitude
//
 //   print("pitch: \(attitude.pitch)")
 //   print("yaw: \(attitude.yaw)")
 //   print("roll: \(attitude.roll)")

///    DispatchQueue.main.async {
//        self.pitch = attitude.pitch
//        self.yaw = attitude.yaw
//        self.roll = attitude.roll
//
//        checkMotion()
//
//        //: After getting it into a ready position
//        func checkMotion(){
//            //debouncer.renewInterval()
//          //  print("Interval renew")
//
//            if (roll > 0.9 && -0.5 ... 0.7 ~= pitch){
//                text = "Start a game "
//
//                if 2.11...2.14 ~= roll{
//                    // When the swing is "registred" points are add and the name is cahnged to next in array
//
//                    if countOfCard + 1 < pack.names.count{
//                        debouncer.renewInterval()
//                        debouncer.handler = {
//                            countOfCard += 1
//                            points += 1
//                            guard let appendignQuestion = receivedPack.0 else{
//                                fatalError("Fuck you cannot append the history")
//                            }
//                            history.append(appendignQuestion)
//                            receivedPack = getQuestion(from: currentPack)
//                            guard let cardie = receivedPack.0?.name else{
//                                showResults.toggle()
//                               // fatalError("Cannot get the question")
//                                return
//                            }
//                            currentPack = receivedPack.1
//                            card = cardie
//                        }
//                    }else{
//                        countOfCard = 0
//                    }
//                    // Changing color red and after 0.6 s back to black
//                    color = .red
//                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(600) ){
//                        color = .black
//
//                    }
//
//                }
//            }else{
//                text = ""
//            }
//        }
//    }//: DispatchQueue
//}
//}//: OnAppear
