//
//  QuestionPack.swift
//  WhoAmIGame
//
//  Created by Richard on 04.12.2022.
//

import Foundation
import RealmSwift


///Model for Realm
class RealmQuestionPack: Object, ObjectKeyIdentifiable, Codable, QuestionPackProtocol{
    @Persisted var id: ObjectId
    @Persisted var name: String = "President"
    @Persisted var author: String = specString
    @Persisted var isFavourite:Bool = false
    @Persisted var imageStr:String = "cinema"
    @Persisted var questions: List<String> = List<String>()
    
    ///Unique ID
    override class func primaryKey() -> String? {
        "id"
    }
    
    ///Get all of the questions from a pack
    func getNames() -> [String] {
        var res:[String] = []
        for q in questions{
            res.append(q)
        }
        return res
    }
    
    ///Does convert it to json
    func toJSON() -> String? {
        let dictionary: [String: Any] = [
            "id": id.stringValue,
            "name": name,
            "author": author,
            "isFavourite": isFavourite,
            "imageStr": imageStr,
            "questions": questions.map { $0 }
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        return jsonData.flatMap { String(data: $0, encoding: .utf8) }
    }
}
