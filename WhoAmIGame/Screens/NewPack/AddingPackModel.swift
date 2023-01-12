//
//  AddingPackModel.swift
//  WhoAmIGame
//
//  Created by Richard on 27.12.2022.
//

import Foundation
import SwiftUI
import RealmSwift


final class AddModel: ObservableObject{
    
    //Published
    @Published var warning = ""
    @Published var currentTextField = ""
    @Published var packName = ""
    @Published var isSame = false
    @Published var imageAlert = false
    @Published var selectedImage = ""
    var realmie : RealmGuess
    
    //Constants
    private let warningText = "Cannot have items with same name"
    private let userDefaults = UserDefaults.standard
    
    //Internal
    var newQuestionPack:QuestionPack
    var names: [String]
    
    init(realm: RealmGuess){
        self.newQuestionPack = QuestionPack()
        self.names = []
        self.realmie = realm
    }
    
    func savePack(){
        if selectedImage != ""{
            if packName != "" && !names.isEmpty{
                newQuestionPack.name = packName
                newQuestionPack.questions.append(objectsIn: names)
                newQuestionPack.imageStr = selectedImage
                newQuestionPack.author = userDefaults.object(forKey: "username") as! String
                realmie.addPack(pack: newQuestionPack)
            }
        }else{
            imageAlert = true
        }
    }
    
    func checkItem(){
        if names.contains(currentTextField){
            warning = warningText
            isSame = true
        }else{
            warning = ""
            isSame = false
        }
    }
    
    func addItem(){
        if !isSame{
            names.append(currentTextField.trimmingCharacters(in: .whitespacesAndNewlines))
            currentTextField = ""
        }
    }
    
}
