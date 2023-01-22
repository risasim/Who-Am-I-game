//
//  Answer.swift
//  WhoAmIGame
//
//  Created by Richard on 01.01.2023.
//

import Foundation

struct Answer: Hashable{
    var question: String
    var correct: Bool
}

struct AnswerPack: Hashable{
    var score: Int = 0
    var answers: [Answer] = []
}
