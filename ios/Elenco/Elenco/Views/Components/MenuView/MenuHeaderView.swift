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
                .font(.system(size: 35, weight: .bold, design: .default))
                .foregroundColor(Color("Tungsten"))

            // Underline
            Rectangle()
                .frame(width: width - 80, height: 1)
                .foregroundColor(Color("Teal"))
                .padding(.top, -5)
        }
    }
}
