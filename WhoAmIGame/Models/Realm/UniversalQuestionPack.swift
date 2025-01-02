//
//  UniversalQuestionPack.swift
//  WhoAmIGame
//
//  Created by Richard Šimoník on 02.01.2025.
//

import Foundation

///Protocol for the views, so that the Realm and the one form API can be displayed by the same View.
struct UniversalQuestionPack:Codable,QP{
    var name:String
    var author:String
    var isFavourite:Bool
    var imageStr:String
    var names:[String]
    
    func getNames() -> [String] {
        return names
    }
    
    init(name: String = "", author: String = "", isFavourite: Bool = false, imageStr: String = "", names: [String] = []) {
        self.name = name
        self.author = author
        self.isFavourite = isFavourite
        self.imageStr = imageStr
        self.names = names
    }
    
    mutating func getFromPocketBase(_ pack:PocketBasePack){
        self.name = pack.name
        self.author = pack.author
        self.imageStr = pack.imageString
        self.names = pack.questions
    }
}
