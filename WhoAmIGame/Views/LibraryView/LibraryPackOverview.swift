//
//  NewPackView.swift
//  WhoAmIGame
//
//  Created by Richard Šimoník on 02.01.2025.
//
import SwiftUI

struct LibraryPackOVerView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var pack:NormalQuestionPack
    @EnvironmentObject var realm: RealmGuess
    @EnvironmentObject var saved:SavedPacks
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Form{
                    Section("game.Info") {
                        Text(pack.name)
                    }
                    Section {
                        List{
                            ForEach(pack.names, id: \.self) { name in
                                Text(name)
                            }
                        }
                    } header: {
                        VStack{
                            Text("game.Items")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    
                }
            }
            .navigationTitle(pack.name)
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
                        if(!saved.isSaved(pack: pack)){
                            saved.addPack(realm: realm, pack: pack)
                        }
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text(saved.isSaved(pack: pack) ?  "game.Saved" : "game.Save")
                    }
                    .disabled(saved.isSaved(pack: pack))
                }
            }
        }
    }
}
