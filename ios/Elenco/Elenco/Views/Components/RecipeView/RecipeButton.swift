//
//  RecipeButton.swift
//  Elenco
//
//  Created by James Bernhardt on 01/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct RecipeButton: View {
    var title: String
    var color: Color
    var width: CGFloat
    var action: ()->()
    
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            Text(self.title)
                .padding(.vertical, 8)
                .frame(width: width)
                .background(self.color).opacity(0.8)
                .foregroundColor(Color.white)
                .font(.custom("HelveticaNeue-Medium", size: 20))
            .cornerRadius(6)
        }
    }
}
