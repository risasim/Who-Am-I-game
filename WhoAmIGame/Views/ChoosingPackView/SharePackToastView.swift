//
//  SharePackToastView.swift
//  WhoAmIGame
//
//  Created by Richard Šimoník on 13.03.2025.
//

import SwiftUI

///View that is presented after pushing the share button informing user about the state of the upload what happens afterwards
struct SharePackToastView: View {
    @Binding var show:String
    var body: some View {
        Text("d")
    }
}

#Preview {
    SharePackToastView(show:.constant("wtf"))
}
