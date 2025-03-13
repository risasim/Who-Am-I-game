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
    
    init(id:String = "",name: String = "", author: String = "", isFavourite: Bool = false, imageStr: String = "", names: [String] = []) {
        self.id = id
        self.name = name
        self.author = author
        self.isFavourite = isFavourite
        self.imageStr = imageStr
        self.names = names
    }
    
    ///Get the questions
    func getNames() -> [String] {
        return names
    }

    ///Creates from JSON response objects that can be used
    mutating func getFromPocketBase(_ pack:PocketBasePack){
        self.id = pack.id
        self.name = pack.name
        if let author = pack.author{
            self.author = author
        }
        self.imageStr = pack.imageString
        if let expand = pack.expand{
            if let qs = expand.questions{
                for name in qs{
                    self.names.append(name.question)
                }
            }
        }
        
    }
}
