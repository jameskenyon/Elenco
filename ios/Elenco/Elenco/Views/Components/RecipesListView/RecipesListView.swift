//
//  RecipesView.swift
//  Elenco
//
//  Created by James Bernhardt on 01/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct RecipesListView: View {
    
    @EnvironmentObject var contentViewDataModel: ContentViewDataModel
    @EnvironmentObject var recipeViewDataModel: RecipeHolderDataModel
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack {
            if recipeViewDataModel.editRecipiesIsShown {
                RecipesHeaderView()
                EditRecipeView()
            } else if recipeViewDataModel.recipeViewIsShown {
                RecipeView()
            } else {
                RecipesHeaderView()
                listView()
            }
        }
        .edgesIgnoringSafeArea(.top)
        
    }
    
    // MARK: - Recipe List View
    public func listView() -> some View {
        ZStack(alignment: .center) {
                
            
            List(recipeViewDataModel.getRecipes()) { recipe in
                RecipeListCell(recipe: recipe)
                    .onTapGesture {
                        self.recipeViewDataModel.displayRecipeView()
                        self.recipeViewDataModel.configureSelectedRecipe(for: recipe)
                    }
            }
                     
            VStack {
                Spacer()
                Button(action: {
                    self.recipeViewDataModel.displayEditRecipeView()
                    self.recipeViewDataModel.configureNewSelectedRecipe()
                }) {
                    Text("+")
                        .font(.custom("HelveticaNeue-Regular", size: 40))
                        .foregroundColor(Color.white)
                }.buttonStyle(OrangeCircleButtonStyle())
            }
        }
    }
}


struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesListView()
    }
}
