//
//  PocketBaseModels.swift
//  WhoAmIGame
//
//  Created by Richard Šimoník on 02.01.2025.
//

import Foundation

import Foundation

///Packs taken from pocketbase
struct PocketBasePacks: Codable {
    let items: [PocketBasePack]
    let page: Int
    let perPage: Int
    let totalItems: Int
    let totalPages: Int
}

///Pack that is fetched from PocketBase
struct PocketBasePack: Codable {
    let author: String
    let collectionId: String?
    let collectionName: String?
    let created: String?
    let expand: PocketBaseExpand?
    let id: String?
    let imageString: String
    let name: String
    let questions: [String]
    let updated: String?
    
}

///Questions that are in pack
struct PocketBaseExpand: Codable {
    let questions: [PocketBaseQuestion]
}

///One question in pack
struct PocketBaseQuestion: Codable {
    let collectionId:String?
    let collectionName:String?
    let id:String?
    let question:String
    let pack:String?
    let created:String?
    let updated:String?
    
    init(collectionId: String? = nil, collectionName: String? = nil, id: String? = nil, question: String, pack: String? = nil, created: String? = nil, updated: String? = nil) {
        self.collectionId = collectionId
        self.collectionName = collectionName
        self.id = id
        self.question = question
        self.pack = pack
        self.created = created
        self.updated = updated
    }
}
