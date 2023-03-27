//
//  SettingsRowView.swift
//  WhoAmIGame
//
//  Created by Richard on 06.12.2022.
//

import SwiftUI

struct SettingsRowView: View {
    
    var label: String
    var description: String? = nil
    var linkLabel:String? = nil
    var linkDestination : String? = nil
    
    var body: some View {
        VStack {
            Divider().padding(.vertical, 4)
            HStack{
                Text(label)
                    .foregroundColor(.gray)
                Spacer()
                if description != nil {
                    Text(description!)
                } else if linkLabel != nil && linkDestination != nil{
                    Link( linkLabel! ,destination: URL(string: "http://\(linkDestination!)")!)
                    Image(systemName: "arrow.up.right.square")
                        .foregroundColor(.blue)
                }else {
                    EmptyView()
                }
                
            }
        }
    }
}

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(label: "Version", description: "0.8")
    }
}
