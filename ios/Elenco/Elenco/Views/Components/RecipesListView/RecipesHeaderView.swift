//
//  RecipesHeaderView.swift
//  Elenco
//
//  Created by James Bernhardt on 03/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct RecipesHeaderView: View {
    @EnvironmentObject var recipeDataModel: RecipeHolderDataModel
    @EnvironmentObject var contentViewDataModel: ContentViewDataModel
    @Environment(\.colorScheme) var colorScheme
    
    var isEditList = false
    var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if !isEditList {
                    MenuIcon()
                    .padding(.leading, 20)
                    .padding(.bottom, -25)
                    .padding(.top, 10)
                    .onTapGesture {
                        self.contentViewDataModel.menuIsShown = true
                        self.recipeDataModel.hideViews()
                    }
                } else {
                    Text("Back")
                        .padding(.leading, 20).padding(.bottom, -25).padding(.top, 10)
                        .font(.custom("HelveticaNeue-Bold", size: 20))
                        .foregroundColor(Color.white)
                        .onTapGesture {
                            self.recipeDataModel.displayRecipeView()
                        }
                }
                                
                Text(title)
                    .padding(.leading, 20).padding(.bottom, -25)
                    .padding(.top, 10)
                    .font(.custom("HelveticaNeue-Bold", size: 36))
                    .foregroundColor(Color.white)
                
                Spacer()
                
                if !isEditList {
                    Text("\(self.recipeDataModel.getRecipes().count)")
                        .padding(.trailing, -5).padding(.bottom, -25)
                        .padding(.top, 10)
                        .font(.custom("HelveticaNeue-Bold", size: 36))
                        .foregroundColor(Color.white)
                    
                    Text(self.recipeDataModel.getRecipes().count == 1 ? "Item":"Items")
                    .padding(.trailing, 20).padding(.bottom, -25)
                        .padding(.top, 25)
                        .font(.custom("HelveticaNeue-Bold", size: 16))
                        .foregroundColor(Color.white)
                    
                }
            }
            .frame(height: 130)
        }
        .background(Color("TealBackground"))
        .cornerRadius(20)
        .shadow(color: colorScheme == .dark ? .clear : Color("Dark-Gray") , radius: 4)
    }
}
