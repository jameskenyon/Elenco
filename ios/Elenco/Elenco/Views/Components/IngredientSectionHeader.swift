//
//  IngredientSectionHeader.swift
//  Elenco
//
//  Created by James Bernhardt on 29/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct ElencoSectionHeader: View {
    
    @EnvironmentObject var listHolderModel: ListHolderDataModel

    var title: String
    
    var body: some View {
        HStack {
            Text((title.first?.uppercased() ?? "") + title.dropFirst())
                .font(.custom("HelveticaNeue-Bold", size: 25))
                .foregroundColor(Color("Teal"))
                .padding(.leading, 35)

                Spacer()
        }
        .background(Color("Background"))
        .listRowInsets(EdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0))
        .contentShape(Rectangle())
            .onTapGesture {
                self.listHolderModel.userFinishedAddingIngredients()
            }
    }
}
