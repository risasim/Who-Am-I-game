//
//  SavedPackModel.swift
//  WhoAmIGame
//
//  Created by Richard Šimoník on 02.01.2025.
//

import Foundation
import RealmSwift
import Realm
import Combine

///Global variable of all saved packs, that are loaded onAppear in WhoAmIApp
var savedPacks: SavedPacks = SavedPacks()

///Write savedPacks into JSON file.
func writeSavedPacksData(_ totals: [SavedPack]) -> Void {
    do {
        let fileURL = try FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("savedPacks.json")
        
        try JSONEncoder()
            .encode(totals)
            .write(to: fileURL)
    } catch {
        print("error writing data")
    }
}

///Read from the JSON file to get the savedPacks
func readSavedPacksData() -> [SavedPack] {
    do {
        let fileURL = try FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("savedPacks.json")
        
        let data = try Data(contentsOf: fileURL)
        let pastData = try JSONDecoder().decode([SavedPack].self, from: data)
        
        return pastData
    } catch {
        print("error reading data")
        return []
    }
}

///Struct for storing packs that have been saved.
class SavedPacks:ObservableObject{
    @Published var savedPacks:[SavedPack] = readSavedPacksData()
    
#if DEBUG
    init() {
        self.savedPacks = readSavedPacksData()
    }
#endif
    
    ///To have an account of those that are uploaded
    func addPack(realm:RealmGuess, pack:NormalQuestionPack){
        DispatchQueue.main.async{
            let newPack = RealmQuestionPack()
            newPack.imageStr = pack.imageStr
            newPack.questions.append(objectsIn: pack.getNames())
            newPack.name = pack.name
            newPack.author = pack.author
            realm.addPack(pack: newPack)
            
            let newSavedPack = SavedPack(pocketBaseId: pack.id ?? "not provided", realmId: newPack.id.stringValue, saved: .now)
            self.savedPacks.append(newSavedPack)
            writeSavedPacksData(self.savedPacks)
            self.savedPacks = readSavedPacksData()
        }
    }
    
    ///For adding the ones that are shared
    func addPack(pack:RealmQuestionPack,pbID:String){
        DispatchQueue.main.async{
            let newSavedPack = SavedPack(pocketBaseId: pbID, realmId: pack.id.stringValue, saved: .now)
            self.savedPacks.append(newSavedPack)
            writeSavedPacksData(self.savedPacks)
            self.savedPacks = readSavedPacksData()
        }
    }
    
    func isSaved(pack:NormalQuestionPack) -> Bool{
        return savedPacks.contains(where: { $0.pocketBaseId == pack.id })
    }
    
    func isSaved(pack:RealmQuestionPack) -> Bool{
        return savedPacks.contains(where: { $0.realmId == pack.id.stringValue })
    }
    
    func removePack(packID:String){
        if let packOffset = savedPacks.firstIndex(where: {$0.realmId == packID}) {
            savedPacks.remove(at: packOffset)
            writeSavedPacksData(self.savedPacks)
            self.savedPacks = readSavedPacksData()
        }else{
            return
        }
    }
}

///Struct for a saved pack.
struct SavedPack:Codable{
    var pocketBaseId:String
    var realmId:String
    var saved:Date
    
    init(pocketBaseId: String, realmId: String, saved: Date) {
        self.pocketBaseId = pocketBaseId
        self.realmId = realmId
        self.saved = saved
    }
}


