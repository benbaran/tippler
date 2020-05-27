//
//  BusinessListView.swift
//  Tippler
//
//  Created by Ben Baran on 5/27/20.
//  Copyright © 2020 Ben Baran. All rights reserved.
//

import SwiftUI

struct BusinessListView: View {
    
    @EnvironmentObject var state: ApplicationState
    
    var body: some View {
        VStack{
            
            List {
                Section(header: Text("Favorites")) {
                    
                    if(state.favorites.count == 0){
                        
                        Text("No Favorites")
                    }
                    else {
                        ForEach(state.favorites, id: \.self) { favorite in
                            HStack{
                                Button(
                                    action: {},
                                    label: { Image(systemName: "heart.fill").foregroundColor(.red) }
                                )
                                    .onTapGesture { self.toggleFavorite(business: favorite)}
                                Text("\(favorite.name)")
                            }
                        }
                    }
                }
                
                Section(header: Text("Other Businesses")) {
                    ForEach(state.others, id: \.self) { business in
                        HStack{
                            Button(
                                action: {},
                                label: { Image(systemName: "heart") }
                            )
                                .onTapGesture { self.toggleFavorite(business: business)}
                            Text("\(business.name)")
                        }
                    }
                }
            }
        }
    }
    
    func toggleFavorite(business: Business){
        
        if(state.favorites.contains(business)){
            
            self.state.favorites = self.state.favorites.filter {$0 != business}
            
            self.state.others.append(business)
        }
        else{
            
            self.state.others = self.state.others.filter {$0 != business}
            
            self.state.favorites.append(business)
        }
        
        sortBusinesses()
    }
    
    
    func sortBusinesses(){
        
        self.state.favorites.sort {
            $0.name < $1.name
        }
        
        self.state.others.sort {
            $0.name < $1.name
        }
    }
}

struct BusinessListView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessListView()
    }
}
