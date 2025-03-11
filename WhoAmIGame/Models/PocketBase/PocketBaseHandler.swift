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
    
    ///Share a pack via first creating pack and then sendin each question, and at the end updating the pack with the iDs of the quesitons
    func share(pack:QuestionPackProtocol){
        var questionIDs:[String] = []
        if let questionPackID = postPack(name: pack.name, author: pack.author, imageString: pack.imageStr){
            for q in pack.getNames(){
                if let qID = postQuestion(question: q, id: questionPackID){
                    questionIDs.append(qID)
                }
            }
        }
    }
    
    ///Post a question to a API, receiving back the id or nil whether it was succesful
    private func postQuestion(question:String, id:String)->String?{
        let sendQ = PocketBaseQuestion(question: question, pack: id)
        let url = URL(string: BASEURL+"/api/collections/questions/records")!
        var questionID:String? = nil
        do{
            let data = try JSONEncoder().encode(sendQ)
            let task = URLSession.shared.dataTask(with: url) { data, response, err in
                if let error = err{
                    print(error)
                }else{
                    guard let htttpResponse = response as? HTTPURLResponse,(200...299).contains(htttpResponse.statusCode) else {
                        print("Error with the response, unexpected status code: \(response)")
                        return
                    }
                    if let data = data,
                       let question = try? JSONDecoder().decode(PocketBaseQuestion.self, from: data) {
                        questionID = question.collectionId
                    }
                }
            }
        }catch{
            print("Error posting the question")
        }
        return questionID
    }
    private func postPack(name:String, author:String, imageString:String)->String?{
        let url = URL(string: BASEURL+"/api/collections/packs/records")!
        let packID:String? = nil
        let task = URLSession.shared.dataTask(with: url) { data, response, err in
            print(data)
        }
        task.resume()
        return packID
    }
}



enum PocketBaseState{
    case notLoaded, loading, error, loaded
}
