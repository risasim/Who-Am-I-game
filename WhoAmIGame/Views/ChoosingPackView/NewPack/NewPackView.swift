//
//  NewPackView.swift
//  WhoAmIGame
//
//  Created by Richard on 08.12.2022.
//

import SwiftUI
import RealmSwift

struct NewPackView: View {
    
    @ObservedObject var packModel: EditAddModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Form{
                    Section("game.Info") {
                        TextField("game.Title", text: $packModel.packName)
                    }
                    Section("game.Image"){
                        ImageGridView(select: $packModel.selectedImage)
                    }
                    Section {
                        HStack{
                            TextField("game.AddItem", text: $packModel.currentTextField)
                                .onChange(of: packModel.currentTextField) { _ in
                                    packModel.checkItem()
                                }
                                .onSubmit {
                                    packModel.addItem()
                                }        
                            Spacer()
                            Button {
                                packModel.addItem()
                            } label: {
                                Image(systemName: "plus.circle")
                            }
                            //IMPORTANT
                            .disabled(packModel.currentTextField.isEmpty || packModel.isSame)
                        }
                        List{
                            ForEach(packModel.names.reversed(), id: \.self) { name in
                                Text(name)
                            }
                            .onDelete { indexset in
                                packModel.deleteItem(at: indexset)
                            }
                        }
                    } header: {
                        VStack{
                            Text("game.Items")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            if packModel.isSame{
                                Text(packModel.warning)
                                    .foregroundColor(.red)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                //maybe isnt neccesary bcs if the view isnt presented viz if dont need ternary operator nor changing the text
                                    .font(.system(size: packModel.isSame ? 0 : 1, weight: .medium))
                                    .padding(packModel.isSame ? 2 : 0)
                            }
                        }
                    }
                    
                }
            }
            .onTapGesture(count: 2, perform: {
                    self.hideKeyboard()
            })
            // For no differenciantions in color in list
            //.background(Color("listBack"))
            .navigationTitle(packModel.packName == "" ?  String(localized:"game.Title") : packModel.packName)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("game.Cancel")
                    }
                    
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        if packModel.checkPack(){
                            presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Text("game.Save")
                    }
                    .alert(isPresented: $packModel.alertBool) {
                        packModel.alert
                    }
                    
                }
            }
        }
    }
}

struct NewPackView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            NewPackView(packModel: EditAddModel(realm: RealmGuess()))
                .environment(\.locale, .init(identifier: "zh-Hans"))
        }
    }
}
