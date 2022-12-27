//
//  SettingsLabelView.swift
//  WhoAmIGame
//
//  Created by Richard on 06.12.2022.
//

import SwiftUI

struct SettingsLabelView: View {
    
    var label: String
    var image: String
    
    var body: some View {
        HStack{
            Text(label.uppercased())
            Spacer()
            Image(systemName: image)
        }
        .fontWeight(.bold)
    }
}

struct SettingsLabelView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLabelView(label: "Application", image: "iphone")
    }
}
