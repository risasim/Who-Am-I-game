//
//  UniversalQuestionPack.swift
//  WhoAmIGame
//
//  Created by Richard Šimoník on 02.01.2025.
//

import Foundation

///Protocol for the views, so that the Realm and the one form API can be displayed by the same View./
protocol QuestionPackProtocol{
    var name:String {get set}
    var author:String {get set}
    var isFavourite:Bool {get set}
    var imageStr:String {get set}
    
    func getNames() -> [String]
}


struct NormalQuestionPack:Codable,QuestionPackProtocol{
    var id:String?
    var name:String
    var author:String
    var isFavourite:Bool
    var imageStr:String
    var names:[String]
    
    func getNames() -> [String] {
        return names
    }
    
    init(id:String = "",name: String = "", author: String = "", isFavourite: Bool = false, imageStr: String = "", names: [String] = []) {
        self.id = id
        self.name = name
        self.author = author
        self.isFavourite = isFavourite
        self.imageStr = imageStr
        self.names = names
    }
    
    mutating func getFromPocketBase(_ pack:PocketBasePack){
        self.id = pack.id
        self.name = pack.name
        self.author = pack.author
        self.imageStr = pack.imageString
        for name in pack.expand.questions{
            self.names.append(name.question)
        }
        
    }
}
