//
//  EmptyPacksView.swift
//  WhoAmIGame
//
//  Created by Richard on 04.12.2022.
//

import SwiftUI

struct EmptyPacksView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("""
            Oops look like you have no saved packs...
            Create your own or download one.
            """)
            .multilineTextAlignment(.center)
            .font(.title3)
            .fontWeight(.semibold)
            HStack{
                Spacer()
            }
            Spacer()
        }
    }
}

struct EmptyPacksView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyPacksView()
    }
}
