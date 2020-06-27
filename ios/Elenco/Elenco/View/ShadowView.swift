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
            .shadow(color: Color("Dark-Gray"), radius: 4)
            .foregroundColor(.white)
            .frame(width: self.width, height: self.height)
    }
    
}

struct ShadowView_Previews: PreviewProvider {
    static var previews: some View {
        ShadowView(width: 200, height: 100)
    }
}
