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
    @Published var color: Color = .accentColor
    
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
    }
    
    //checking if phone is in right orientation -> start game
    func checkOrientation(ended: Bool){
        orientation = UIDevice.current.orientation
        print(UIDevice.current.orientation.isValidInterfaceOrientation)
        //maybe problem when turingn phone durign game ????!!!!!!!!
        if !started && !ended{
            print(orientation.rawValue)
            if !orientation.isLandscape{
                //print("orientation not right")
                question = "Please turn over your phone to start the game"
            }else{
                //print("Game gonna start")
                started = true
                startGame()
            }
        }
    }
    
    func startGame(){
        print(self.motionManager.deviceMotionUpdateInterval)
        self.readyPack = self.readyPack.shuffled()
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
        //making sure if phone is in landscape ?? maybe usable even for starting the game and chaging the views ??
        if (-0.5 ... 0.7 ~= pitch){
            if 2.20...2.35 ~= roll || -2.35 ... -2.20 ~= roll{
                self.color = .green
                debouncer.renewInterval()
                debouncer.handler = {
                    //RESOLVE TO CHANGE IMMEDEIATELY AFTER SWING????
                    self.rightAnswer()
                }
            }else if 0.7...0.85 ~= roll || -0.85 ... -0.7 ~= roll{
                self.color = .red
                debouncer.renewInterval()
                debouncer.handler = {
                    //RESOLVE TO CHANGE IMMEDEIATELY AFTER SWING????
                    self.wrongAnswer()
                }
            }
        }
    }
    
    func startTimer(){
        //print("timer started")
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
            answers.index += 1
            self.color = .accentColor
        }else{
            endGame()
        }
    }
    func rightAnswer(){
        index += 1
        answers.score += 1
        answers.answers.append(Answer(question: question, correct: true))
        getQuestion()
    }
    
    func wrongAnswer(){
        index += 1
        answers.answers.append(Answer(question: question, correct: false))
        getQuestion()
    }
    
    func endGame(){
        self.question = "End of the Game"
        feedbackManager.impactOccurred()
        self.motionManager.stopDeviceMotionUpdates()
        self.index = 0
    }
    
}
