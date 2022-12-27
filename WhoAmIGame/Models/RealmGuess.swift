//
//  RealmGuess.swift
//  WhoAmIGame
//
//  Created by Richard on 04.12.2022.
//

import Foundation
import RealmSwift

class RealmGuess: ObservableObject{
    
    @Published var realm = try! Realm()
}
