//
//  Question.swift
//  WhoAmIGame
//
//  Created by Richard on 04.12.2022.
//

import Foundation

import RealmSwift

class Question: Object, ObjectKeyIdentifiable{
    @Persisted var id: ObjectId
    @Persisted var name: String = ""
 //   @Persisted(originProperty: "names") var group: LinkingObjects<QuestionPack>
    
    override class func primaryKey() -> String?{
        "id"
    }
    
}
