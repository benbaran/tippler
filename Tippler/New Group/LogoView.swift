//
//  LogoView.swift
//  Tippler
//
//  Created by Ben Baran on 5/18/20.
//  Copyright © 2020 Ben Baran. All rights reserved.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        
        Image("Logo")
            .resizable()
            .scaledToFit()
            .padding()
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
