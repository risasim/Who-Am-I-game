//
//  Navigator.swift
//  WhoAmIGame
//
//  Created by Richard on 01.01.2023.
//

import Foundation
import SwiftUI

class Navigator:ObservableObject{
    @Published var path = NavigationPath()
    
    func getPath(){
        print(self.path)
    }
}
