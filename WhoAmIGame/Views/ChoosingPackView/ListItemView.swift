//
//  ListItemView.swift
//  WhoAmIGame
//
//  Created by Richard on 04.12.2022.
//

import SwiftUI

struct ListItemView: View {
    
    @Environment(\.colorScheme) var colorScheme
    var pack : RealmQuestionPack
    
    @EnvironmentObject var realmie: RealmGuess
    @EnvironmentObject var saved:SavedPacks
    @EnvironmentObject var pbHandler:PocketBaseHandler
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
                .aspectRatio(1, contentMode: .fit)
               // .frame(width: width, height: width)
            RoundedRectangle(cornerRadius: 23)
                .foregroundColor(.white)
            Blur(style: colorScheme == .dark ? .prominent : .dark)
            Image(pack.imageStr)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
               // .frame(width: width, height: width)
                .mask(LinearGradient(gradient: Gradient(colors: [Color.white, Color.white.opacity(0)]), startPoint: .top, endPoint: .bottom))
            VStack{
                HStack{
                    Button {
                        realmie.manageFavourite(id: pack.id)
                        changed.toggle()
                    } label: {
                        Image(systemName: pack.isFavourite ? "heart.fill" : "heart")
                            .font(.system(size: 25))
                            .foregroundColor(pack.isFavourite ? .red : .white)
                    }

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
       // .frame(width: width, height: width)
        .cornerRadius(23)
        .contextMenu {
            Button {
                realmie.manageFavourite(id: pack.id)
                changed.toggle()
            } label: {
                if pack.isFavourite{
                    Label("pack.makeUnFavorite", systemImage: "heart.slash")
                }else{
                    Label("pack.makeFavourite", systemImage: "heart.fill")
                }
            }

            Button {
                editPack.toggle()
            } label: {
                Label("pack.editPack", systemImage: "pencil")
            }
            Button{
                pbHandler.share(pack:pack, completion:  { state in
                    DispatchQueue.main.async {
                        if state == .uploaded {
                            print("Pack successfully uploaded!") // Replace with UI feedback
                        } else {
                            print("Failed to upload pack.") // Replace with alert
                        }
                    }
                }
                )
            }label:{
                Label("pack.share", systemImage: "square.and.arrow.up")
            }
            Button(role: .destructive) {
                saved.removePack(packID: pack.id.stringValue)
                realmie.deletePack(id: pack.id)
                changed.toggle()
            } label: {
                Label("pack.deletePack", systemImage: "minus.circle")
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
        let pack = RealmQuestionPack()
        ListItemView(pack: pack,changed: .constant(false))
            .onAppear {
                pack.author = "Richie"
            }
    }
}
