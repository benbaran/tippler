//
//  DataService.swift
//  Tippler
//
//  Created by Ben Baran on 5/24/20.
//  Copyright © 2020 Ben Baran. All rights reserved.
//

import Foundation


class ApplicationState : ObservableObject{
    
    @Published var user = User()
    
    @Published var favorites = [Business]()
    
    @Published var others = [Business]()
    
    @Published var tips = [Tip]()
}

class User {
    
    var id: UUID = UUID()
    
    var username: String = String()
}

class Business : Decodable, Hashable, Identifiable{
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Business, rhs: Business) -> Bool {
        
        return lhs.id == rhs.id
    }
    
    
    var id: Int = 0
    
    var name: String = String()
    
    var amount: Int = 0
    
}

class Tip: Decodable, Identifiable {
    
    var id: Int = 0;
    
    var dateCreated: String = String()
    
    var amount: Int = 0
    
    var business: String = String()
    
    var user: String = String()
}


enum DataServiceError: Error {
    
    case noDataAvailable
    case cannotProcessData
}


class DataService{
    
    static func GetUser(userIdentifier: (UUID)) -> User{
        
        print("Getting user data for \(userIdentifier)")
        
        return User()
        
    }
    
    
    static func getBusinesses(completion: @escaping(Result<[Business], Error>) -> Void){
        
        print("Getting business data.")
        
        let urlString = "https://tippler-api-websocket.azurewebsites.net/business";
        
        guard let resourceUrl = URL(string: urlString) else {
            
            return
        }
        
        #if DEBUG
        print("Calling \(urlString)");
        #endif
        
        let dataTask = URLSession.shared.dataTask(with: resourceUrl) {data, _, _ in
            
            guard let jsonData = data else {
                
                completion(.failure(DataServiceError.noDataAvailable))
                
                return
            }
            
            do {
                
                #if DEBUG
                //print(String(data: data!, encoding: String.Encoding.utf8) as String?)
                #endif
                
                let decoder = JSONDecoder()
                
                let response = try decoder.decode([Business].self, from: jsonData)
                
                let businesses = response
                
                #if DEBUG
                print("Sucessfully retrieved business data.");
                #endif
                
                completion(.success(businesses))
            }
            catch{
                
                completion(.failure(DataServiceError.cannotProcessData))
            }
            
        }
        
        dataTask.resume()
    }
    
    
    static func getTips(completion: @escaping(Result<[Tip], Error>) -> Void){
        
        print("Getting tip data.")
        
        let urlString = "https://tippler-api-websocket.azurewebsites.net/tip";
        
        guard let resourceUrl = URL(string: urlString) else {
            
            return
        }
        
        #if DEBUG
        print("Calling \(urlString)");
        #endif
        
        let dataTask = URLSession.shared.dataTask(with: resourceUrl) {data, _, _ in
            
            guard let jsonData = data else {
                
                completion(.failure(DataServiceError.noDataAvailable))
                
                return
            }
            
            do {
                
                #if DEBUG
                //print(String(data: data!, encoding: String.Encoding.utf8) as String?)
                #endif
                
                let decoder = JSONDecoder()
                
                let response = try decoder.decode([Tip].self, from: jsonData)
                
                let tips = response
                
                #if DEBUG
                print("Sucessfully retrieved tip data.");
                #endif
                
                completion(.success(tips))
            }
            catch{
                
                completion(.failure(DataServiceError.cannotProcessData))
            }
            
        }
        
        dataTask.resume()
    }
}

