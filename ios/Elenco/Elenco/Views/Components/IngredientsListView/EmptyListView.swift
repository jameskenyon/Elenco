//
//  EmptyListView.swift
//  Elenco
//
//  Created by James Kenyon on 01/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

/*
 
 A view that will display when the user has no items in their list.
 
 */

struct EmptyListView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
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
                        .padding(25)
                        .background(Color("Background"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(colorScheme == .dark ? Color.white : Color.clear, lineWidth: 2)
                                .shadow(color: Color.black.opacity(0.14), radius: 4)
                        )
                }
                .padding().padding(.horizontal)

                if colorScheme == .dark {
                    Text("Becomes")
                        .font(.custom("HelveticaNeue-Bold", size: 22))
                        .padding(.top)
                } else {
                    Image("orange_arrow")
                }
                    
                IngredientListCell(ingredient: Ingredient(ingredientID: UUID(), name: "Carrot", aisle: "Produce", quantity: "1kg", parentList: nil))
                    .padding().padding(.horizontal).padding(.bottom)
                
                Text("Tap the circle to complete or swipe to delete an ingredient from your list.")
                    .padding().padding(.horizontal, 25)
                    .font(.custom("HelveticaNeue-Regular", size: 22))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .foregroundColor(Color("BodyText"))
        }
        .background(Color("Background"))
    }
}

#if DEBUG
struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView().environment(\.colorScheme, .dark)
    }
}
#endif


