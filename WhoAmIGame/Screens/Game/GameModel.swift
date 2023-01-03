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
    
    @Published var question = "Please turn over your phone to start the game"
    @Published var time:Int = 0
    @Published var started = false
    @Published var color: Color = .white
    
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
    var answers: AnswerPack = AnswerPack()
    
    
    init(pack: QuestionPack){
        self.readyPack = pack.questions.shuffled()
        //checkOrientation()
    }
    
    //checking if phone is in right orientation -> start game
    func checkOrientation(ended: Bool){
        orientation = UIDevice.current.orientation
        if !started && !ended{
            if !orientation.isLandscape{
                print("orientation not right")
                question = "Please turn over your phone to start the game"
            }else{
                print("Game gonna start")
                started = true
                startGame()
            }
        }
    }
    
    func startGame(){
        //start telemetry
        print("game started")
        self.motionManager.startDeviceMotionUpdates(to: self.queue) { (data: CMDeviceMotion?, error: Error?) in
            guard let data = data else {
                print("Error: \(error!)")
                return
            }
            
            let attitude: CMAttitude = data.attitude
            
           // print("pitch: \(attitude.pitch)")
           // print("yaw: \(attitude.yaw)")
           // print("roll: \(attitude.roll)")
            
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
        //print("check")
        //   if (roll > 0.9 && -0.5 ... 0.7 ~= pitch){
        //maybe to delete was before the orieantation trick
        //probably vital for understating the orientation of the phone (left or right landscape!!)
        if 2.20...2.35 ~= roll || -2.35 ... -2.20 ~= roll{
            // Changing color red and after 0.6 s back to black
            self.color = .green
            debouncer.renewInterval()
            debouncer.handler = {
                //RESOLVE TO CHANGE IMMEDEIATELY AFTER SWING????
                self.rightAnswer()
            }
        }else if 0.7...0.85 ~= roll || -0.85 ... -0.7 ~= roll{
            print("lol ok")
            self.color = .red
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
        print("timer started")
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
            self.color = .white
        }else{
            endGame()
        }
    }
    func rightAnswer(){
        index += 1
        answers.score += 1
        answers.answers.append(Answer(question: question, correct: true))
        print(answers)
        getQuestion()
    }
    
    func wrongAnswer(){
        index += 1
        answers.answers.append(Answer(question: question, correct: false))
        getQuestion()
    }
    
    func endGame(){
        self.question = "End of the Game"
        //end telemetry
        self.motionManager.stopDeviceMotionUpdates()
        // export points and answers
        //push new view!!!!!!!!!!!!!!! ???
        self.index = 0
        
    }
    
}
