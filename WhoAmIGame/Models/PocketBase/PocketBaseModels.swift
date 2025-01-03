//
//  PocketBaseModels.swift
//  WhoAmIGame
//
//  Created by Richard Šimoník on 02.01.2025.
//

import Foundation

import Foundation

struct PocketBasePacks: Codable {
    let items: [PocketBasePack]
    let page: Int
    let perPage: Int
    let totalItems: Int
    let totalPages: Int
}

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

struct PocketBaseExpand: Codable {
    let questions: [PocketBaseQuestion]
}

struct PocketBaseQuestion: Codable {
    let question: String
}
