//
//  QuestionPack.swift
//  WhoAmIGame
//
//  Created by Richard on 04.12.2022.
//

import Foundation
import RealmSwift

class QuestionPack: Object, ObjectKeyIdentifiable{
    @Persisted var name: String = "President"
    @Persisted var author: String = "Coolie"
    @Persisted var isFavourite:Bool = false
    @Persisted var imageStr:String = ""
    @Persisted var names: List<Question> = List<Question>()
}
