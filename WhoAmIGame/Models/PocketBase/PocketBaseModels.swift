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
    let collectionId: String
    let collectionName: String
    let created: String
    let expand: PocketBaseExpand
    let id: String
    let imageString: String
    let name: String
    let questions: [String]
    let updated: String
    
}

///Questions that are in pack
struct PocketBaseExpand: Codable {
    let questions: [PocketBaseQuestion]
}

///One question in pack
struct PocketBaseQuestion: Codable {
    let question: String
}
