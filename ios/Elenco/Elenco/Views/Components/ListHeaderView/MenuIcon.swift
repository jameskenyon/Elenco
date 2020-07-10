//
//  MenuIcon.swift
//  Elenco
//
//  Created by James Bernhardt on 10/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct MenuIcon: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Capsule()
                .frame(width: 25, height: 4)
                .foregroundColor(Color.white)
                .padding(2)
            
            Capsule()
            .frame(width: 15, height: 4)
                .foregroundColor(Color.white)
            .padding(2)
            
            Capsule()
            .frame(width: 25, height: 4)
                .foregroundColor(Color.white)
            .padding(2)
        }
    }
}

struct MenuIcon_Previews: PreviewProvider {
    static var previews: some View {
        MenuIcon()
    }
}
