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
        let url = URL(string: BASEURL+"/api/collections/packs/records?filter=(isPublic=trueC)&expand=questions&fields=*,expand.questions.question")!
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
            if let data = data {
                do {
                    let packs = try? JSONDecoder().decode(PocketBasePacks.self, from: data)
                     var normalPacks:[NormalQuestionPack] = []
                    if let ps = packs{
                        for pack in ps.items{
                             var newPack = NormalQuestionPack()
                             newPack.getFromPocketBase(pack)
                             normalPacks.append(newPack)
                         }
                    }
                     self.state = PocketBaseState.loaded
                     completionHandler(normalPacks)
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            }
        })
        task.resume()
    }
    
    ///Share a pack via first creating pack and then sendin each question, and at the end updating the pack with the iDs of the quesitons
    func share(pack: QuestionPackProtocol, completion: @escaping (PocketBaseState) -> Void) {
        postPack(name: pack.name, author: pack.author, imageString: pack.imageStr) { questionPackID in
            guard let questionPackID = questionPackID else {
                print("Pack creation failed!")
                completion(.error)
                return
            }

            print("Pack successfully created with ID: \(questionPackID), now posting questions...")

            let group = DispatchGroup()
            var questionIDs: [String] = []
            var hasError = false
            for q in pack.getNames() {
                group.enter()
                self.postQuestion(question: q, id: questionPackID) { qID in
                    if let qID = qID {
                        questionIDs.append(qID)
                    } else {
                        hasError = true
                    }
                    group.leave()
                }
            }

            group.notify(queue: .main) {
                self.updatePack(id: questionPackID ,name: pack.name, author: pack.author, imageString: pack.imageStr, questions: questionIDs) { packID in
                    if packID == nil {
                        hasError = true
                        print("executed not good")
                    }
                    print("executed")
                }
                completion(hasError ? .error : .uploaded)
            }
        }
    }
    
    /// Update the pack with the questions
    private func updatePack(id: String,name: String, author: String, imageString: String, questions:[String],completion: @escaping (String?) -> Void){
        let pack = PocketBasePack(imageString: imageString, name: name, questions:questions, isPublic: false)
        let url = URL(string: BASEURL + "/api/collections/packs/records/\(id)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PATCH"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let data = try JSONEncoder().encode(pack)
            urlRequest.httpBody = data
        } catch {
            print("Failed to encode JSON")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, err in
            if let err = err {
                print("Request error: \(err.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Unexpected status code: \(String(describing: response))")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let responseData = try JSONDecoder().decode(PocketBasePack.self, from: data)
                completion(responseData.id)  // Use decoded value
            } catch {
                print("Failed to decode JSON: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
    
    ///Post a question to a API, receiving back the id or nil whether it was succesful
    private func postQuestion(question: String, id: String, completion: @escaping (String?) -> Void) {
        let sendQ = PocketBaseQuestion(question: question, pack: id)
        let url = URL(string: BASEURL + "/api/collections/questions/records")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let data = try JSONEncoder().encode(sendQ)
            urlRequest.httpBody = data
        } catch {
            print("Error encoding JSON: \(error)")
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, err in
            if let err = err {
                print("Network error: \(err.localizedDescription)")
                completion(nil)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Unexpected status code: \(String(describing: response))")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }

            do {
                let responseData = try JSONDecoder().decode(PocketBaseQuestion.self, from: data)
                completion(responseData.id)
            } catch {
                print("Error decoding response: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
    
    ///Post post to the PocketBase via Post request
    private func postPack(name: String, author: String, imageString: String, completion: @escaping (String?) -> Void) {
        let url = URL(string: BASEURL + "/api/collections/packs/records")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let data = try JSONEncoder().encode(PocketBasePack(imageString: imageString, name: name, isPublic: false))
            urlRequest.httpBody = data
        } catch {
            print("Failed to encode JSON")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, err in
            if let err = err {
                print("Request error: \(err.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Unexpected status code: \(String(describing: response))")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let responseData = try JSONDecoder().decode(PocketBasePack.self, from: data)
                completion(responseData.id)  // Use decoded value
            } catch {
                print("Failed to decode JSON: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
}


///State of the PocketBase communication
enum PocketBaseState{
    case notLoaded, loading, error, loaded, uploaded
}
