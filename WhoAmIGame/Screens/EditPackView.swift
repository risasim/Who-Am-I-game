//
//  EditPackView.swift
//  WhoAmIGame
//
//  Created by Richard on 13.01.2023.
//

import SwiftUI
import RealmSwift

struct EditPackView: View {
    
    @StateObject var realm = RealmGuess()
    @State var pack: QuestionPack
    
    var body: some View {
        VStack{
            TextField("Username", text: $pack.name)
        }
        .navigationTitle(pack.name)
    }
}

struct EditPackView_Previews: PreviewProvider {
    static var previews: some View {
        EditPackView(pack: QuestionPack())
    }
}


struct FakeQuestionPack{
    @State var id: ObjectId
    @State var name: String = "President"
    @State var author: String = "Coolie"
    @State var isFavourite:Bool = false
    @State var imageStr:String = "nature"
    @State var questions: [String] = []
    
    init(pack: QuestionPack) {
        self.id = pack.id
        self.name = pack.name
        self.author =  pack.author
        self.isFavourite =  pack.isFavourite
        self.imageStr =  pack.imageStr
        self.questions.append(contentsOf: pack.questions)
    }
}
