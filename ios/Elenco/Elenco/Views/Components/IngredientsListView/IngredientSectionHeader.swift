//
//  IngredientSectionHeader.swift
//  Elenco
//
//  Created by James Bernhardt on 29/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct IngredientSectionHeader: View {
    
    var title: String
    
    var body: some View {
        HStack {
            Text((title.first?.uppercased() ?? "") + title.dropFirst())
                .font(.system(size: 25, weight: .bold, design: .default))
                .foregroundColor(Color("Teal"))
                .padding(.leading, 35)
                .padding(.vertical, 20)

                Spacer()
        }
        .background(Color("Background"))
        .listRowInsets(EdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0))
    }
}


struct IngredientSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        IngredientSectionHeader(title: "A")
    }
}
