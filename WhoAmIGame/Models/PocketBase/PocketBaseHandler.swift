//
//  PocketBaseHandler.swift
//  WhoAmIGame
//
//  Created by Richard Šimoník on 02.01.2025.
//

import Foundation
import Network


class PocketBaseHandler:ObservableObject{
    var state:PocketBaseState = PocketBaseState.notLoaded
    
    ///Function that fetches the packs from the PocketBase.
    //Using escaping so that the rest of the app does not wait for the packs
    func fetchPacks(completionHandler: @escaping ([NormalQuestionPack])-> Void){
        self.state = PocketBaseState.loading
        //Fetching from the PocketBase
        let url = URL(string: BASEURL+"/api/collections/packs/records?expand=questions&fields=*,expand.questions.question")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error {
#warning("Not ideal solution for the error")
                print("Error fetching packs: \(error)")
                self.state = PocketBaseState.error
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data,
               let packs = try? JSONDecoder().decode(PocketBasePacks.self, from: data) {
                var normalPacks:[NormalQuestionPack] = []
                for pack in packs.items{
                    var newPack = NormalQuestionPack()
                    newPack.getFromPocketBase(pack)
                    normalPacks.append(newPack)
                }
                self.state = PocketBaseState.loaded
                completionHandler(normalPacks)
            }
        })
        task.resume()
    }
    
    func share(pack:RealmQuestionPack){
        do{
            let data = try JSONEncoder().encode(pack)
        }catch{
            print("There has been error creating JSON")
        }
    }
}



enum PocketBaseState{
    case notLoaded, loading, error, loaded
}
