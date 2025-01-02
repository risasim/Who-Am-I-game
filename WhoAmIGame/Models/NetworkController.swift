//
//  NetworkController.swift
//  WhoAmIGame
//
//  Created by Richard on 31.08.2024.
//

import Foundation
import Network

class NetworkController:ObservableObject{
    @Published var isConnected:Bool = false
    
    private let monitor = NWPathMonitor()
    
    init() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.isConnected = true
            } else {
                self.isConnected = false
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    func getNetworkState() -> Bool {
            return isConnected
        }
    
}
