//
//  MainView.swift
//  Tippler
//
//  Created by Ben Baran on 5/18/20.
//  Copyright © 2020 Ben Baran. All rights reserved.
//

import SwiftUI
import SwiftSignalRClient

struct MainView: View {
    
    @EnvironmentObject var state: ApplicationState
    
    let defaults = UserDefaults.standard
    
    let hubConnection = HubConnectionBuilder(url: URL(string: "https://tippler-signalr.azurewebsites.net/tipplerHub")!)
        .withLogging(minLogLevel: .info)
        .build()
    
    var body: some View {
        
        VStack{
            
            LogoView()
            
            TabView {
                BusinessListView()
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("Businesses")
                    }

                TipListView()
                    .tabItem {
                        Image(systemName: "square.and.pencil")
                        Text("Tips")
                    }
            }
            
            
        }.onAppear(){
            
            self.GetData();
            
            self.hubConnection.on(method: "TipAdded") {
                
                self.GetData();
            }
            
            self.hubConnection.start()
        }
    }
    
    func GetData(){
        
        let userIdentifier = getUserIdentifier()
        
        self.state.user = DataService.GetUser(userIdentifier: userIdentifier)
        
        DataService.getBusinesses { result in
            
            switch result {
                
            case .failure(let error):
                
                print(error)
                
            case .success(let businesses):
                
                DispatchQueue.main.async {
                    
                                  
                    self.state.others = businesses
                    
                    print("Got \(businesses.count) businesses.")
                }
            }
        }
        
        DataService.getTips { result in
            
            switch result {
                
            case .failure(let error):
                
                print(error)
                
            case .success(let tips):
                
                DispatchQueue.main.async {
                    
                    self.state.tips = tips
                    
                    print("Got \(tips.count) tips.")
                }
            }
        }
    }
    
    func getUserIdentifier() -> UUID {
        
        var userIdentifier = self.defaults.string(forKey: "UserIdentifier")
        
        if (userIdentifier == nil){
            
            userIdentifier = UUID().uuidString
            
            self.defaults.set(userIdentifier, forKey: "UserIdentifier")
            
            print("Set user identifier to \(String(describing: userIdentifier))")
            
        }
        
        return UUID(uuidString: userIdentifier!)!
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
