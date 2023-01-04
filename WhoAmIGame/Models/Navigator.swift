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
    @Published var isAcitve = false
    
    func getPath(){
        print(self.path)
    }
}
