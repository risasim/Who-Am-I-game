//
//  AddingPackModel.swift
//  WhoAmIGame
//
//  Created by Richard on 27.12.2022.
//

import Foundation
import SwiftUI
import RealmSwift


final class EditAddModel: ObservableObject{
    
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
    private var customPack = false
    
    //Internal
    private var newQuestionPack:QuestionPack
    var names: [String]
    
    
    init(realm: RealmGuess, pack: QuestionPack = QuestionPack()){
        self.names = []
        self.realmie = realm
        self.newQuestionPack = pack
        if self.newQuestionPack.author != specString{
            self.customPack = true
            self.packName = pack.name
            self.names.append(contentsOf: pack.questions)
            self.selectedImage = pack.imageStr
        }
    }
    
    
    
    //Have to resolve how to differetiate or remake the saving logic
    //maybe bind only the properties of quesitonpack instead of having separate variables
    // problem with directly working with parameters
    
    func savePack(){
        if selectedImage != ""{
            if packName != "" && !names.isEmpty{
                if customPack{
                    print(names)
                    realmie.updatePack(id: newQuestionPack.id, name: packName, names: names, imgStr: selectedImage)
                }else{
                    newQuestionPack.name = packName
                    newQuestionPack.questions.append(objectsIn: names)
                    newQuestionPack.imageStr = selectedImage
                    newQuestionPack.author = userDefaults.object(forKey: "username") as! String
                    realmie.addPack(pack: newQuestionPack)
                }
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
