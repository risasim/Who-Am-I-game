//
//  PocketBaseHandler.swift
//  WhoAmIGame
//
//  Created by Richard Šimoník on 02.01.2025.
//

import Foundation
import Network


struct PocketBaseHandler{
    
    func fetchPacks(completionHandler: @escaping ([PocketBasePack])-> Void){
        var packs:[PocketBasePack]
        
        let url = URL(string: "https://api.punkapi.com/v2/beers")!
        
        completionHandler(packs)
    }
}
