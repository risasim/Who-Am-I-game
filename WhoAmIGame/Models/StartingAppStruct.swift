//
//  StartingAppStruct.swift
//  WhoAmIGame
//
//  Created by Richard on 12.01.2023.
//

import Foundation

struct StartingDatabase{
    
    private var realm : RealmGuess
    private var data: Data
    private var readyData : [OtherQuestionPack] = []
    
    init(){
        self.realm = RealmGuess()
        self.data = Data(jsonData.utf8)
        getJSON()
        
    }
    
    mutating func getJSON(){
        let decoder = JSONDecoder()

        do {
            let packs = try decoder.decode([OtherQuestionPack].self, from: data)
            readyData = packs
            addToDatabase()
            print(packs)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addToDatabase(){
        for pack in readyData{
            let newQuestionPack = QuestionPack()
            newQuestionPack.name = pack.name
            newQuestionPack.isFavourite = pack.isFavourite
            newQuestionPack.author = pack.author
            newQuestionPack.imageStr = pack.imageStr
            newQuestionPack.questions.append(objectsIn: pack.names)
            realm.addPack(pack: newQuestionPack)
        }
    }
    
}

struct OtherQuestionPack:Codable{
    var name:String
    var author:String
    var isFavourite:Bool
    var imageStr:String
    var names:[String]
}

let jsonData = """
[
   {
     "name" : "Presidents",
     "author" : "WW",
     "isFavourite": false,
     "imageStr": "presidents",
     "names": [
        "JFK",
        "Ronald Reagan",
        "Barrack Obama",
        "Donald Trump",
        "George W.Bush",
        "Woodrow Wilson",
        "George Washington",
        "Theodor Roosevelt",
        "Thomas Jefferson",
        "Richard Nixon",
        "Abraham Lincoln",
        "F. D. Roosevelt",
        "Dwight Eisenhower",
        "Gerald Ford",
        "Jimmy Carter",
        "Bill Clinton"
     ]
   },
    {
         "name" : "Marvel",
         "author" : "WW",
         "isFavourite": false,
         "imageStr": "comics",
         "names": [
            "Iron man",
            "Hulk",
            "Black widow",
            "Ant-man",
            "Hawkeye",
            "Captain America",
            "Doctor Strange",
            "Scarlet Witch",
            "Thor"
         ]
       }
]
"""
