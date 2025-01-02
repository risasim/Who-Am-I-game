//
//  QuestionPack.swift
//  WhoAmIGame
//
//  Created by Richard on 04.12.2022.
//

import Foundation
import RealmSwift

protocol QP{
    var name:String {get set}
    var author:String {get set}
    var isFavourite:Bool {get set}
    var imageStr:String {get set}
    
    func getNames() -> [String]
}

class RealmQuestionPack: Object, ObjectKeyIdentifiable, Codable, QP{
    @Persisted var id: ObjectId
    @Persisted var name: String = "President"
    @Persisted var author: String = specString
    @Persisted var isFavourite:Bool = false
    @Persisted var imageStr:String = "cinema"
    @Persisted var questions: List<String> = List<String>()
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    func getNames() -> [String] {
        var res:[String] = []
        for q in questions{
            res.append(q)
        }
        return res
    }
    
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
