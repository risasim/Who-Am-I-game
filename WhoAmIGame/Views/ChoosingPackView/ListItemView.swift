//
//  ListItemView.swift
//  WhoAmIGame
//
//  Created by Richard on 04.12.2022.
//

import SwiftUI

struct ListItemView: View {
    
    @Environment(\.colorScheme) var colorScheme
    var pack : QuestionPack
    @ObservedObject private var realmie = RealmGuess()
    @Binding var changed : Bool
    @State var editPack: Bool = false
    
    var body: some View {
        ZStack{
            Image(pack.imageStr)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 160, height: 160)
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
            Blur(style: colorScheme == .dark ? .prominent : .dark)
            Image(pack.imageStr)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 160, height: 160)
                .mask(LinearGradient(gradient: Gradient(colors: [Color.white, Color.white.opacity(0)]), startPoint: .top, endPoint: .bottom))
            VStack{
                HStack{
                    Image(systemName: pack.isFavourite ? "heart.fill" : "heart")
                        .foregroundColor(pack.isFavourite ? .red : .white)
                    Spacer()
                }
                Spacer()
                Text(pack.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                HStack {
                   // Text(String(pack.questions.count))
                    Text(pack.author)
                }
            }
            .foregroundColor(.white)
            .padding(20)
        }
        .frame(width: 160, height: 160)
        .cornerRadius(20)
        .contextMenu {
            Button {
                realmie.manageFavourite(id: pack.id)
                changed.toggle()
            } label: {
                if pack.isFavourite{
                    Label("Make unfavourite", systemImage: "heart.slash")
                }else{
                    Label("Make favourite", systemImage: "heart.fill")
                }
            }

            Button {
                editPack.toggle()
            } label: {
                Label("Edit pack", systemImage: "pencil")
            }
            
            Button(role: .destructive) {
                realmie.deletePack(id: pack.id)
                changed.toggle()
            } label: {
                Label("Delete pack", systemImage: "minus.circle")
            }
        }
        .sheet(isPresented: $editPack) {
            NewPackView(packModel: EditAddModel(realm: realmie,pack: pack))
                .onDisappear {
                    changed.toggle()
                }
        }
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(pack: QuestionPack(),changed: .constant(false))
    }
}
