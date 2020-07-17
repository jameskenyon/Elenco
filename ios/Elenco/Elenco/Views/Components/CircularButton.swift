//
//  CircularButton.swift
//  Elenco
//
//  Created by James Kenyon on 12/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct OrangeCircleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label.padding().modifier(MakeSquareBounds()).background(Circle().fill(Color("Orange")))
    }
}

struct MakeSquareBounds: ViewModifier {

    var size: CGFloat = 70
    func body(content: Content) -> some View {
        let c = ZStack {
            content.alignmentGuide(HorizontalAlignment.center) { (vd) -> CGFloat in
                return vd[HorizontalAlignment.center]
            }
        }
        return c.frame(width: size, height: size)
    }
    
}
