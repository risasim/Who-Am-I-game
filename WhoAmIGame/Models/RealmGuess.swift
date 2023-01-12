//
//  RealmGuess.swift
//  WhoAmIGame
//
//  Created by Richard on 04.12.2022.
//

import Foundation
import RealmSwift

class RealmGuess: ObservableObject{
    
    //@Published var realm = try! Realm()
    @Published private(set) var questionPacks: [QuestionPack] = []
    private(set) var localRealm: Realm?
    
    init() {
        openRealm()
        getPacks()
    }
    
    func openRealm(){
        do{
            localRealm = try Realm()
        }catch{
            print("Error opening Realm: \(error)")
        }
    }
    
    func addPack(pack: QuestionPack){
        if let localRealm = localRealm{
            do{
                try localRealm.write({
                    let newPack = pack
                    localRealm.add(newPack)
                    print("Pack added")
                    getPacks()
                })
            }catch{
                print("Error adding pack to Realm \(error)")
            }
        }
    }
    
    func getPacks(){
        if let localRealm = localRealm{
            let packs = localRealm.objects(QuestionPack.self)
            questionPacks = []
            packs.forEach { pack in
                questionPacks.append(pack)
            }
        }
    }
    
    func updatePack(){
        //TO BE ADDED
    }
    
    func deletePack(id:ObjectId){
        if let localRealm = localRealm{
            do{
                let delPack = localRealm.objects(QuestionPack.self).filter(NSPredicate(format: "id == %@", id))
                guard !delPack.isEmpty else {return}
                
                try localRealm.write({
                    localRealm.delete(delPack)
                    getPacks()
                })
            }catch{
                print("Error deleting pack \(error)")
            }
        }
    }
    
}
