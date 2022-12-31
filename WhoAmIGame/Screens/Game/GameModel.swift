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
    @Published var ended:Bool = false
    
    //Pack operations
    private var readyPack : [String]
    private var index = 0
    
    //Models
    private let motionManager = CMMotionManager()
    private let queue = OperationQueue()
    private let debouncer = Debouncer(timeInterval: 0.7)
    private var timer: Timer!
    
    //Orientation
    private var orientation = UIDevice.current.orientation
    private var pitch: Double = 0
    private var roll: Double = 0
    private var yaw : Double = 0
    
    //Final
    @Published var answers: [String] = []
    @Published var correct: [Bool] = []
    @Published var points: Int = 0
    
    
    init(pack: QuestionPack){
        self.readyPack = pack.questions.shuffled()
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
        //   if (roll > 0.9 && -0.5 ... 0.7 ~= pitch){
        //maybe to delete was before the orieantation trick
        //probably vital for understating the orientation of the phone (left or right landscape!!)
        if 2.20...2.35 ~= roll || -2.35 ... -2.20 ~= roll{
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
        }else if 0.7...0.85 ~= roll || -0.85 ... -0.7 ~= roll{
            print("lol ok")
            self.color = .red
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(700) ){
                self.color = .white
            }
            debouncer.renewInterval()
            debouncer.handler = {
                //RESOLVE TO CHANGE IMMEDEIATELY AFTER SWING????
                self.wrongAnswer()
            }
        }
        //   }else{
        //was when user wasn having phone in wanted orienataiton
        //  }
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
            question = readyPack[index]
        }else{
            endGame()
        }
    }
    func rightAnswer(){
        index += 1
        points += 1
        answers.append(question)
        correct.append(true)
        getQuestion()
    }
    
    func wrongAnswer(){
        index += 1
        answers.append(question)
        correct.append(false)
        getQuestion()
    }
    
    func endGame(){
        self.question = "End of the Game"
        //end telemetry
        self.motionManager.stopDeviceMotionUpdates()
        // export points and answers
        self.ended = true
        //push new view!!!!!!!!!!!!!!! ???
        self.index = 0
        
    }
    
}
