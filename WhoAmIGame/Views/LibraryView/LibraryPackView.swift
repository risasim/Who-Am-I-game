//
//  ListItemView.swift
//  WhoAmIGame
//
//  Created by Richard Šimoník on 02.01.2025.
//


//
//  ListItemView.swift
//  WhoAmIGame
//
//  Created by Richard on 04.12.2022.
//

import SwiftUI

struct LibraryPackView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var pack : NormalQuestionPack
    @State var showDetails = false
    
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
            RoundedRectangle(cornerRadius: 23)
                .foregroundColor(.white)
            Blur(style: colorScheme == .dark ? .prominent : .dark)
            Image(pack.imageStr)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .mask(LinearGradient(gradient: Gradient(colors: [Color.white, Color.white.opacity(0)]), startPoint: .top, endPoint: .bottom))
            VStack{
                HStack{
                    Button {
                       
                    } label: {
                        if #available(iOS 17.0, *) {
                            Image(systemName: pack.isFavourite ? "checkmark.diamond" : "square.and.arrow.down")
                                .contentTransition(.symbolEffect(.replace))
                                .font(.system(size: 25))
                                .foregroundColor(pack.isFavourite ? .red : .white)
                        } else {
                            Image(systemName: pack.isFavourite ? "checkmark.diamond" : "square.and.arrow.down")
                                .font(.system(size: 25))
                                .foregroundColor(pack.isFavourite ? .red : .white)
                        }
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
        .onTapGesture {
            showDetails.toggle()
        }
       // .frame(width: width, height: width)
        .cornerRadius(23)
        .defersSystemGestures(on: .bottom)
        .sheet(isPresented: $showDetails) {
            LibraryPackOVerView(pack: $pack)
        }
    }
}

