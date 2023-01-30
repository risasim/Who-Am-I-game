//
//  Utility.swift
//  WhoAmIGame
//
//  Created by Richard on 08.12.2022.
//

import Foundation
import SwiftUI


//constant arrays
//array of the name of pictures in assets
let images: [String] = ["films", "literature", "presidents", "art", "lab","animals", "comics", "celebrit","classic", "literature 1", "cinema", "nature", "discovery", "notes"]
//maybe delete later
let times: [Int] = [10 ,30, 45, 60, 90]
let languages: [String] = ["en", "cz", "sk"]
//UI
let feedbackManager = UIImpactFeedbackGenerator(style: .medium)
let columnSpacing: CGFloat = 10
let rowSpacing:CGFloat = 10
var gridLayout:[GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
}

//used in init QuestionPack for to differentiate the new and already created pack -> AddModel
let specString = "6jbw81euPQMuckOJZSekflU5j"

let noFavString = """
Ups look like you have no favourites.
You can make pack favourite by long pressing on the icon.
"""

let changePosString = "Please turn over your phone to start the game"

