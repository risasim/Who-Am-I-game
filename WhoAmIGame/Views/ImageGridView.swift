//
//  ImageGridView.swift
//  WhoAmIGame
//
//  Created by Richard on 10.12.2022.
//

import SwiftUI

struct ImageGridView: View {
    
    @Binding var select: String
    @State var isSelected:Bool = false
    
    var gridLayoutImage:[GridItem] {
        return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 1)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            LazyHStack{
                Section {
                    ForEach(images, id: \.self) { image in
                        ZStack {
                            Image(image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .scaleEffect(select == image ? 1.3 : 1)
                            Color(.white)
                                .opacity(select == image ? 0.7 : 0)
                            Image(systemName:"checkmark.seal")
                                .imageScale(.large)
                                .foregroundColor(Color("CheckColor"))
                                .opacity(select == image ? 1 : 0)
                        }
                        
                        .frame(width: 100, height: 100)
                        .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("CheckColor"), lineWidth: select == image ? 6 : 0))
                        .cornerRadius(20)
                        .onTapGesture {
                            select = (select == image) ? "" : image
                        }
                    }
                } header: {
                    // Button for image picker
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }
    }
}

struct ImageGridView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridView(select: .constant("discovery"))
    }
}
