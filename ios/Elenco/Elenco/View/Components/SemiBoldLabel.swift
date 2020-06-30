//
//  SemiBoldLabel.swift
//  Elenco
//
//  Created by James Kenyon on 29/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

/*
 
 A view that will allow some of the text to be changed to bold
 and the rest of the text will remain the same colour.
 
 */

struct SemiBoldLabel: View {
    
    private(set) var text: String
    private(set) var query: String
    private(set) var font: Font
    
    var body: some View {
        var returnText = Text("")
        let components = text.components(separatedBy: query)
        for i in 0...components.count - 1 {
            returnText = returnText + Text(components[i]).font(font).foregroundColor(Color("Dark-Gray"))
            if i < components.count - 1 {
                returnText = returnText +
                    Text(query)
                        .font(font)
                        .foregroundColor(Color.black)
            }
        }
        return returnText
    }
}

#if DEBUG
struct SemiBoldLabel_Previews: PreviewProvider {
    static var previews: some View {
        SemiBoldLabel(text: "Carrot Juice", query: "Car", font: .custom("HelveticaNeue", size: 30))
    }
}
#endif
