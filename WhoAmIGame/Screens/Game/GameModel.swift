//
//  GameModel.swift
//  WhoAmIGame
//
//  Created by Richard on 04.12.2022.
//

import SwiftUI
import CoreMotion

final class GameModel: ObservableObject {
    // MARK: - Published properties
    @AppStorage("gameTime") private(set) var countTime: Int = 30
    @Published var question = "game.TurnOver"
    @Published var time: Int = 0
    @Published var color: Color = .accentColor
    @Published var landscape = false
    
    // MARK: - Private properties
    private var readyPack: [String]
    private var index = 0
    private let motionManager = CMMotionManager()
    private let queue = OperationQueue()
    private let debouncer = Debouncer(timeInterval: 0.7)
    private var timer: Timer?
    
    // MARK: - Constants
    private enum MotionThresholds {
        static let pitchRange = -0.5...0.7
        static let rollCorrectRange = 2.20...2.35
        static let rollIncorrectRange = 0.7...0.85
    }
    
    // MARK: - Public properties
    var answers = AnswerPack()
    
    // MARK: - Initialization
    init(pack: QuestionPack) {
        self.readyPack = pack.questions.shuffled()
    }
    
    // MARK: - Public methods
    func checkOrientation() {
        resetGame()
        let isLandscape = UIDevice.current.orientation.isLandscape
        print("Checking orientation: current = \(landscape), device = \(isLandscape)")
        
        guard isLandscape && !landscape else { return }
        
        print("Setting to landscape")
        landscape = true
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
        AppDelegate.orientationLock = .landscape
        startGame()
    }

    func startGame() {
        readyPack.shuffle()
        setupMotionUpdates()
        getQuestion()
        startTimer()
    }
    
    // MARK: - Private methods
    private func setupMotionUpdates() {
        motionManager.startDeviceMotionUpdates(to: queue) { [weak self] data, error in
            guard let self = self, let data = data else {
                print("Motion update error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            DispatchQueue.main.async {
                self.processMotionData(data.attitude)
            }
        }
    }
    
    private func processMotionData(_ attitude: CMAttitude) {
        guard MotionThresholds.pitchRange.contains(attitude.pitch) else { return }
        
        if MotionThresholds.rollCorrectRange.contains(attitude.roll) || MotionThresholds.rollCorrectRange.contains(-attitude.roll) {
            handleAnswer(correct: true)
        } else if MotionThresholds.rollIncorrectRange.contains(attitude.roll) || MotionThresholds.rollIncorrectRange.contains(-attitude.roll) {
            handleAnswer(correct: false)
        }
    }
    
    private func handleAnswer(correct: Bool) {
        color = correct ? .green : .red
        debouncer.renewInterval()
        debouncer.handler = { [weak self] in
            guard let self = self else { return }
            correct ? self.rightAnswer() : self.wrongAnswer()
        }
    }
    
    private func startTimer() {
        time = countTime
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.time -= 1
            if self.time <= 0 {
                self.timer?.invalidate()
                self.endGame()
            }
        }
    }
    
    private func getQuestion() {
        guard index < readyPack.count else {
            endGame()
            return
        }
        
        question = readyPack[index]
        color = .accentColor
    }
    
    private func rightAnswer() {
        index += 1
        answers.score += 1
        answers.answers.append(Answer(question: question, correct: true))
        getQuestion()
    }
    
    private func wrongAnswer() {
        index += 1
        answers.answers.append(Answer(question: question, correct: false))
        getQuestion()
    }
    
    func endGame() {
        question = "End of the Game"
        motionManager.stopDeviceMotionUpdates()
        index = 0
    }
    func resetGame() {
        landscape = false
        time = 0
        index = 0
        question = "game.TurnOver"
        color = .accentColor
        answers = AnswerPack()
    }
}
