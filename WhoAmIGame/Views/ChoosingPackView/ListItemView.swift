//
//  ListItemView.swift
//  WhoAmIGame
//
//  Created by Richard on 04.12.2022.
//

import SwiftUI

struct ListItemView: View {
    
    var pack : QuestionPack
    @ObservedObject private var realmie = RealmGuess()
    
    var body: some View {
        ZStack{
            Image(pack.imageStr)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 160, height: 160)
            Blur(style: .prominent)
            Image(pack.imageStr)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 160, height: 160)
                .mask(LinearGradient(gradient: Gradient(colors: [Color.white, Color.white.opacity(0)]), startPoint: .top, endPoint: .bottom))
            VStack{
                Spacer()
                Text(pack.name)
                    .font(.title3)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                HStack {
                    Text(String(pack.questions.count))
                    Text(pack.author)
                }
            }
            .padding(20)
        }
        .frame(width: 160, height: 160)
        .cornerRadius(20)
        .contextMenu {
            Button {
                //
            } label: {
                Label("Edit pack", systemImage: "pencil")
            }
            
            Button(role: .destructive) {
                realmie.deletePack(id: pack.id)
            } label: {
                Label("Delete pack", systemImage: "minus.circle")
            }
        }
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(pack: QuestionPack())
    }
}
