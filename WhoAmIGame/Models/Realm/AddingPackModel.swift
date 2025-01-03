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
    @Published var alertBool = false
    @Published var alert: Alert = Alert(title: Text("Default aler"), message: Text("Message"))
    @Published var selectedImage = ""
    var realmie : RealmGuess
    
    //Constants
    private let warningText = String(localized: "pack.warninngSame")
    private let userDefaults = UserDefaults.standard
    private var customPack = false
    
    //Internal
    private var newQuestionPack:RealmQuestionPack
    var names: [String]
    
    
    init(realm: RealmGuess, pack: RealmQuestionPack = RealmQuestionPack()){
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
    
    enum Alerts: String{
        case Image = "pack.noImage"
        case Name = "pack.noName"
        case NotEnoughNames = "pack.notEnoughQ"
        
        func getDesc() -> String{
            switch self{
            case .Image:
                return "Please select image for your questionpack in the section Image."
            case .Name:
                return "Please enter name for the pack."
            case .NotEnoughNames:
                return "Please enter more questions. Minimum for pack is 5 questions."
            }
        }
    }
    
    
    func checkPack() -> Bool{
        if selectedImage != ""{
            if packName != "" {
                if !names.isEmpty && names.count >= 5{
                    savePack()
                    return true
                }else{
                    alert = Alert(title: Text(LocalizedStringKey(Alerts.NotEnoughNames.rawValue)), message: Text(Alerts.NotEnoughNames.getDesc()))
                }
            }else{
                alert = Alert(title: Text(LocalizedStringKey(Alerts.Name.rawValue)), message: Text(Alerts.Name.getDesc()))
            }
        }else{
            //probably delete
            alert = Alert(title: Text(LocalizedStringKey(Alerts.Image.rawValue)), message: Text(Alerts.Image.getDesc()))
        }
        alertBool = true
        return false
    
    }
    
    func savePack(){
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
       
    
    func checkItem(){
        if names.contains(currentTextField){
            warning = warningText
            isSame = true
        }else{
            warning = ""
            isSame = false
        }
    }
    
    func deleteItem(at offsets: IndexSet){
        names.remove(atOffsets: offsets)
    }
    
    func addItem(){
        if !isSame{
            if currentTextField != ""{
                names.append(currentTextField.trimmingCharacters(in: .whitespacesAndNewlines))
                currentTextField = ""
            }
        }
    }
    
}
