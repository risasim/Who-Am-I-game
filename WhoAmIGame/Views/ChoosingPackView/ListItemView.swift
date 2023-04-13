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
    @EnvironmentObject var realmie: RealmGuess
    @Binding var changed : Bool
    @State var editPack: Bool = false
    
    var width: CGFloat {
          if UIDevice.current.userInterfaceIdiom == .phone {
              return UIScreen.main.bounds.width * 0.44
          } else {
              return UIScreen.main.bounds.width * 0.2
          }
      }
    
    
    var body: some View {
        ZStack{
            Image(pack.imageStr)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: width)
            RoundedRectangle(cornerRadius: 23)
                .foregroundColor(.white)
            Blur(style: colorScheme == .dark ? .prominent : .dark)
            Image(pack.imageStr)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: width)
                .mask(LinearGradient(gradient: Gradient(colors: [Color.white, Color.white.opacity(0)]), startPoint: .top, endPoint: .bottom))
            VStack{
                HStack{
                    Image(systemName: pack.isFavourite ? "heart.fill" : "heart")
                        .font(.system(size: 25))
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
        .frame(width: width, height: width)
        .cornerRadius(23)
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
        .defersSystemGestures(on: .bottom)
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
        let pack = QuestionPack()
        ListItemView(pack: pack,changed: .constant(false))
            .onAppear {
                pack.author = "Richie"
            }
    }
}
