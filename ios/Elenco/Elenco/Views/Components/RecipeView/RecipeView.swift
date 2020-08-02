//
//  RecipeView.swift
//  Elenco
//
//  Created by James Bernhardt on 01/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct RecipeView: View {
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                RecipeHeaderView(image: #imageLiteral(resourceName: "tomatoPasta"), geometry: geometry)
                    .edgesIgnoringSafeArea(.all)
                RecipieIngredientMethodPagerView()
            }
            .edgesIgnoringSafeArea(.all)
        }
        
        
    }
}




struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}
