//
//  RealmGuess.swift
//  WhoAmIGame
//
//  Created by Richard on 04.12.2022.
//

import Foundation
import RealmSwift
import SwiftUI

class RealmGuess: ObservableObject{
    
    @Published private(set) var questionPacks: [RealmQuestionPack] = []
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
    
    func addPack(pack: RealmQuestionPack){
        if let localRealm = localRealm{
            do{
                try localRealm.write({
                    let newPack = pack
                    localRealm.add(newPack)
                    getPacks()
                })
            }catch{
                print("Error adding pack to Realm \(error)")
            }
        }
    }
    
    func addToDatabase(pack:NormalQuestionPack){
        let newQuestionPack = RealmQuestionPack()
        newQuestionPack.name = pack.name
        newQuestionPack.isFavourite = pack.isFavourite
        newQuestionPack.author = pack.author
        newQuestionPack.imageStr = pack.imageStr
        newQuestionPack.questions.append(objectsIn: pack.names)
        addPack(pack: newQuestionPack)
    }
    
    func getPacks(){
        if let localRealm = localRealm{
            let packs = localRealm.objects(RealmQuestionPack.self)
            questionPacks = []
            packs.forEach { pack in
                if !pack.isInvalidated{
                    questionPacks.append(pack)
                }
            }
        }
    }
    
    func updatePack(id: ObjectId, name:String, names: [String], imgStr: String){
        if let localRealm = localRealm{
            do{
                let updatePack = localRealm.objects(RealmQuestionPack.self).filter(NSPredicate(format: "id == %@", id))
                guard !updatePack.isEmpty else {return}
                try localRealm.write({
                    updatePack[0].name = name
                    //Checking whether the question already exist
                    for ques in names{
                        if !updatePack[0].questions.contains(ques){
                            print(ques)
                            updatePack[0].questions.append(ques)
                        }
                    }
                    updatePack[0].imageStr = imgStr
                    getPacks()
                })
            }catch{
                print("Error updating pack \(error)")
            }
        }
    }
    
    func manageFavourite(id:ObjectId){
        if let localRealm = localRealm{
            do{
                let updatePack = localRealm.objects(RealmQuestionPack.self).filter(NSPredicate(format: "id == %@", id))
                guard !updatePack.isEmpty else {return}
                try localRealm.write({
                    updatePack[0].isFavourite.toggle()
                    getPacks()
                })
            }catch{
                print("Error managing favourite state \(error)")
            }
        }
    }
    
    func deletePack(id:ObjectId){
        if let localRealm = localRealm{
            do{
                let delPack = localRealm.objects(RealmQuestionPack.self).filter(NSPredicate(format: "id == %@", id))
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
