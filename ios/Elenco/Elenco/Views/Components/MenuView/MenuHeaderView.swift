//
//  MenuHeaderView.swift
//  Elenco
//
//  Created by James Bernhardt on 10/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct MenuHeaderView: View {
    
    var title: String
    var width: CGFloat
    
    var body: some View {
        // Title
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom("HelveticaNeue-Bold", size: 35))
                .foregroundColor(Color("Tungsten"))
                .padding(.top, 15)

            // Underline
            Rectangle()
                .frame(width: width - 80, height: 2)
                .foregroundColor(Color(#colorLiteral(red: 0, green: 0.9176470588, blue: 0.662745098, alpha: 1)))
                .padding(.top, -10)
        }
    }
}
