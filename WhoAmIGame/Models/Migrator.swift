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
   //     let config = Realm.Configuration(schemaVersion: 4){ migration, oldSchemaVersion in
   //         if oldSchemaVersion < 1{
   //             //Add new fields
   //             migration.enumerateObjects(ofType: QuestionPack.className()) { _, newObject in
   //                 newObject!["names"] = List<Question>()
   //             }
   //         }
   //         if oldSchemaVersion < 4{
   //             migration.enumerateObjects(ofType: QuestionPack.className()) { _, newObject in
   //                 newObject!["questions"] = List<String>()
   //             }
   //         }
   //     }
   //     Realm.Configuration.defaultConfiguration = config
   //     let _ = try! Realm()
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            schemaVersion: 10,
            migrationBlock: { migration, oldSchemaVersion in


            },
            deleteRealmIfMigrationNeeded: true
        )
    }
        

}
