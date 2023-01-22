//
//  PlusButtonView.swift
//  WhoAmIGame
//
//  Created by Richard on 22.01.2023.
//

import SwiftUI

struct PlusButtonView: View {
    
    @Binding var variable: Bool
    
    var body: some View {
        ZStack {
            Image(systemName: "plus")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(15)
                .background {
                    Circle()
                        .foregroundColor(.black)
                }
            Button {
                variable = true
            } label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(15)
                    .background {
                        Circle()
                            .foregroundColor(.blue)
                    }
            }
        .padding()
        }
    }
}

struct PlusButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlusButtonView(variable: .constant(false))
    }
}
