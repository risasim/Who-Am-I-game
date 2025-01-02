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
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Form{
                    Section("Info") {
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
                            Text("Items")
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
                        Text("Cancel")
                    }
                    
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
}
