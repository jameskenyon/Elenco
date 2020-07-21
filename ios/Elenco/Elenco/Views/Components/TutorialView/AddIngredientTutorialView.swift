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

struct AddIngredientTutorialView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text("Elenco automatically detects the quantity of your ingredient.")
                    .padding().padding(.bottom)
                    .font(.custom("HelveticaNeue-Regular", size: 22))
                    .fixedSize(horizontal: false, vertical: true)
                
                ZStack {
                    if colorScheme == .dark {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white, lineWidth: 2)
                    } else {
                        RoundedRectangle(cornerRadius: 15)
                           .foregroundColor(Color("Background"))
                           .shadow(color: Color("Light-Gray"), radius: 5)
                    }
                    HStack {
                        Text("1kg Carrots")
                            .font(.custom("HelveticaNeue-Medium", size: 22))
                            .padding(25)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("+")
                            .font(.custom("HelveticaNeue-Bold", size: 34))
                            .foregroundColor(Color("Orange"))
                            .padding(.trailing, 20).padding(.bottom, 4)
                    }
                }
                .padding()
                
                Text("Becomes")
                    .font(.custom("HelveticaNeue-Bold", size: 22))
                    .padding(.top)
                    .foregroundColor(Color("Orange"))
            
                IngredientListCell(ingredient: Ingredient(ingredientID: UUID(), name: "Carrot", aisle: "Produce", quantity: "1kg", parentList: nil))
                    .padding().padding(.bottom)
                    .allowsHitTesting(false)
                
                Text("Tap the circle to complete, or swipe and drag left to delete an ingredient from your list.")
                    .padding()
                    .font(.custom("HelveticaNeue-Regular", size: 22))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .foregroundColor(Color("BodyText"))
            .padding(.horizontal, UIDevice.deviceIsIPad() ? 30 : 5)
        }
        .background(Color.clear)
    }
}

#if DEBUG
struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        AddIngredientTutorialView().environment(\.colorScheme, .dark)
    }
}
#endif


