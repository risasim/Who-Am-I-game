//
//  Migrator.swift
//  WhoAmIGame
//
//  Created by Richard on 04.12.2022.
//

import Foundation
import RealmSwift

class Migrator{
    init(){
        updateSchema()
    }
    
    func updateSchema(){
        let config = Realm.Configuration(schemaVersion: 2){ migration, oldSchemaVersion in
            if oldSchemaVersion < 1{
                //Add new fields
                migration.enumerateObjects(ofType: QuestionPack.className()) { _, newObject in
                    newObject!["names"] = List<Question>()
                }
            }
        }
        Realm.Configuration.defaultConfiguration = config
        let _ = try! Realm()
    }
}
