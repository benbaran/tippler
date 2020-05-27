//
//  SignalRService.swift
//  Tippler
//
//  Created by Ben Baran on 5/24/20.
//  Copyright © 2020 Ben Baran. All rights reserved.
//

import Foundation
import SwiftSignalRClient

class SignalRService {
    
    private var connection: HubConnection
    
    public init(url: URL) {
        connection = HubConnectionBuilder(url: url).withLogging(minLogLevel: .error).build()
        connection.on(method: "MessageReceived", callback: { (user: String, message: String) in
            do {
                self.handleMessage(message)
            } catch {
                print(error)
            }
        })
        
        connection.start()
    }
    
    private func handleMessage(_ message: String) {
        print(message)
    }
    
}
