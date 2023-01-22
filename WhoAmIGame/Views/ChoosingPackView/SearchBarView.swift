//
//  SearchBarView.swift
//  WhoAmIGame
//
//  Created by Richard on 22.01.2023.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    @Binding var favouritesToggle: Bool
    
    var body: some View {
        HStack{
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(UIColor.secondaryLabel))
                TextField("Search pack...", text: $searchText)
                    .foregroundColor(.accentColor)
                    .overlay(
                        Button(action: {
                            searchText = ""
                            self.hideKeyboard()
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(Color.accentColor)
                                .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        })
                        .padding()
                        .disabled(searchText.isEmpty)
                        ,alignment: .trailing
                    )
            }
            .font(.headline)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(UIColor.systemBackground))
                    .shadow(color: Color.accentColor.opacity(0.20), radius: 5, x: 0, y: 0)
            }
            Button {
                favouritesToggle.toggle()
            } label: {
                Image(systemName: "list.star")
                    .foregroundColor(favouritesToggle ? .blue : .accentColor)
                    .font(.title)
            }

        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""), favouritesToggle: .constant(false))
        SearchBarView(searchText: .constant("djsfk"), favouritesToggle: .constant(false))
            .preferredColorScheme(.dark)
    }
}
