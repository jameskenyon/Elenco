//
//  EmptyListView.swift
//  Elenco
//
//  Created by James Kenyon on 01/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct EmptyListView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Your list is empty.")
                    .font(.custom("HelveticaNeue-Medium", size: 30))
                    .padding().padding(.bottom)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("To get started, tap on the add ingredient text field above to add something to your list")
                    .padding().padding(.horizontal, 30)
                    .font(.custom("HelveticaNeue-Regular", size: 22))
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("Elenco automatically detects the quantity of your ingredient.")
                    .padding().padding(.horizontal, 30).padding(.bottom)
                    .font(.custom("HelveticaNeue-Regular", size: 22))
                    .fixedSize(horizontal: false, vertical: true)
                
                HStack {
                    Text("1kg Carrots")
                        .font(.custom("HelveticaNeue-Medium", size: 22))
                        .foregroundColor(Color("Tungsten"))
                        .padding(25)
                        .background(Color.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.clear, lineWidth: 2)
                                .shadow(color: Color.black.opacity(0.14), radius: 4)
                        )
                }
                .padding().padding(.horizontal)

                Image("orange_arrow")
                    
                IngredientListCell(ingredient: Ingredient(name: "Carrot", aisle: "Produce", quantity: "1kg"))
                    .padding().padding(.horizontal).padding(.bottom)
                
                Text("Tap the circle to complete or swipe to delete an ingredient from your list.")
                    .padding().padding(.horizontal, 25)
                    .font(.custom("HelveticaNeue-Regular", size: 22))
                .fixedSize(horizontal: false, vertical: true)
            }
            .foregroundColor(Color("Tungsten"))
        }
    }
}

#if DEBUG
struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
    }
}
#endif


