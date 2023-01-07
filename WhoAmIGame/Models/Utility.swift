//
//  Utility.swift
//  WhoAmIGame
//
//  Created by Richard on 08.12.2022.
//

import Foundation
import SwiftUI


//constant arrays
let images: [String] = ["films", "literature", "presidents", "art", "lab", "comics", "celebrit","classic", "literature 1", "cinema", "nature", "discovery", "notes", ]
//maybe delete later
let times: [Int] = [10 ,30, 45, 60, 90]
//UI
let columnSpacing: CGFloat = 10
let rowSpacing:CGFloat = 10
var gridLayout:[GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
}
