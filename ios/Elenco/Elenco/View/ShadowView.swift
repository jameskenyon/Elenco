//
//  ShadowView.swift
//  Elenco
//
//  Created by James Bernhardt on 27/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct ShadowView: View {
    
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .cornerRadius(10)
            .shadow(color: .black, radius: 5)
            .foregroundColor(.white)
            .frame(width: self.width, height: self.height)
    }
    
}
