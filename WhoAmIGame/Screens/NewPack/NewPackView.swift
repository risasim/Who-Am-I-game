//
//  NewPackView.swift
//  WhoAmIGame
//
//  Created by Richard on 08.12.2022.
//

import SwiftUI
import RealmSwift

struct NewPackView: View {
    
    @ObservedObject var packModel: AddModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            VStack {
                Form{
                    Section("Info") {
                        TextField("Add title", text: $packModel.packName)
                    }
                    Section("Image"){
                        ImageGridView(select: $packModel.selectedImage)
                    }
                    Section {
                        HStack{
                            TextField("Add item", text: $packModel.currentTextField)
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
                        }
                    } header: {
                        VStack{
                            Text("Items")
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
            .navigationTitle(packModel.packName)
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
                        packModel.savePack()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                    }
                    .alert("Image not selected", isPresented: $packModel.imageAlert) {
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
            NewPackView(packModel: AddModel(realm: RealmGuess()))
        }
    }
}