//
//  NoNetworkView.swift
//  Tippler
//
//  Created by Ben Baran on 5/18/20.
//  Copyright © 2020 Ben Baran. All rights reserved.
//

import SwiftUI

struct NoNetworkView: View {
    var body: some View {
        
        VStack{
            
            LogoView()
            
            Spacer();
            
            Text("Tippler requires and Internet connection. Please turn on Cellular or WiFi data and try again.")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding(.bottom, 100)
            
            Spacer()
            
        }
    }
}

struct NoNetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NoNetworkView()
    }
}
