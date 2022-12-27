//
//  NewPackView.swift
//  WhoAmIGame
//
//  Created by Richard on 08.12.2022.
//

import SwiftUI
import RealmSwift

struct NewPackView: View {
    
    @State var title: String = ""
    @State var names: [String] = []
    @State var newName: String = ""
    let newQuestionPack = QuestionPack()
    
    @State var warning = ""
    @State var isSame = false
    @State var nowSelected = ""
    
    @State var imageAlert = false
    
    @AppStorage ("username") var username: String = ""
    
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedResults(QuestionPack.self) var questionPacks
    
    var body: some View {
        NavigationStack {
            VStack {
                Form{
                    Section("Info") {
                        TextField("Add title", text: $title)
                    }
                    Section("Image"){
                        ImageGridView(select: $nowSelected)
                    }
                    Section {
                        HStack{
                            TextField("Add item", text: $newName)
                                .onChange(of: newName) { newValue in
                                    checkItem()
                                }
                                .onSubmit {
                                    if !isSame{
                                        addNewItem()
                                    }
                                }
                            Spacer()
                            Button {
                                addNewItem()
                            } label: {
                                Image(systemName: "plus.circle")
                            }
                            .disabled(newName.isEmpty || isSame)
                        }
                        List{
                            ForEach(names.reversed(), id: \.self) { name in
                                Text(name)
                            }
                        }
                    } header: {
                        VStack{
                            Text("Items")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            if isSame{
                                Text(warning)
                                    .foregroundColor(.red)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .font(.system(size: isSame ? 0 : 1, weight: .medium))
                                    .padding(isSame ? 2 : 0)
                            }
                        }
                    }
                    
                }
            }
            // For no differenciantions in color in list
            //.background(Color("listBack"))
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                    
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        //action
                        //DOESNT WORK UNLESS TRYING TO WRITE TWO AFTER EACHOTHER!!
                        // UPGRADE TO MVVM
                        if nowSelected != ""{
                            newQuestionPack.name = title
                            newQuestionPack.imageStr = nowSelected
                            //  newQuestionPack.names = names
                            newQuestionPack.author = username
                            $questionPacks.append(newQuestionPack)
                            presentationMode.wrappedValue.dismiss()
                        }else{
                            imageAlert = true
                        }
                    } label: {
                        Text("Save")
                    }
                    .alert("Image not selected", isPresented: $imageAlert) {
                        Text("Please select image for your questionpack in the section Image.")
                    }
                    
                }
        }
        }
    }
}

struct NewPackView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            NewPackView()
        }
    }
}

// MARK: - Functions

extension NewPackView{
    
    func addNewItem(){
        let newQuestion = Question()
        newQuestion.name = newName
        newQuestionPack.names.append(newQuestion)
        names.append(newName)
        newName = ""
    }
    
    func checkItem(){
        for naamie in names{
            if naamie == newName{
                warning = "Cannot have items with same name"
                isSame = true
            }else{
                warning = ""
                isSame = false
            }
        }
    }
    
}
