//
//  TipListView.swift
//  Tippler
//
//  Created by Ben Baran on 5/27/20.
//  Copyright © 2020 Ben Baran. All rights reserved.
//

import SwiftUI

struct TipListView: View {
    
    @EnvironmentObject var state: ApplicationState
    
    var body: some View {
        
        List(self.state.tips){tip in
            HStack{
                VStack(alignment: .leading){
                    Text(tip.business)
                    Text(tip.user).font(.footnote)
                }
                Spacer()
                VStack(alignment: .trailing){
                    Text("$\(tip.amount)")
                    
                    Text("\(self.getDateString(from: tip.dateCreated))")
                        .font(.footnote)
                }
            }
        }
    }
    
    func getDateString(from: String) -> String{
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let date = dateFormatter.date(from: from)!
        
        let dateFormatterPrint = DateFormatter()
        
        dateFormatterPrint.dateFormat = "MMM d, h:mm a"
        
        let result = dateFormatterPrint.string(from: date)
        
        return result
    }
    
}

struct TipListView_Previews: PreviewProvider {
    static var previews: some View {
        TipListView()
    }
}
