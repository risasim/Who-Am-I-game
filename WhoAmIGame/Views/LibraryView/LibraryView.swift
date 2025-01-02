//
//  LibraryView.swift
//  WhoAmIGame
//
//  Created by Richard on 31.08.2024.
//

import SwiftUI

struct LibraryView: View {
    @State var isSettingsShown: Bool = false
    var body: some View {
        NavigationStack{
            ChooseConnectionView()
                .sheet(isPresented: $isSettingsShown, content: {
                    SettingsView()
                })
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            isSettingsShown = true
                        } label: {
                            Image(systemName: "gear")
                                .font(.title2)
                                .padding(.bottom,0)
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        Text("Who Am I ?")
                            .font(.system(size: 27, weight: .bold, design: .rounded))
                            .padding(.bottom, 0)
                    }
                    
                }
                .navigationBarTitleDisplayMode(.inline) 
        }
    }
}

#Preview {
    LibraryView()
        .environmentObject(RealmGuess())
}
