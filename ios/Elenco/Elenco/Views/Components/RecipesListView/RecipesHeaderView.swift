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
    
    var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                MenuIcon()
                    .padding(.leading, 20)
                    .padding(.bottom, -25)
                    .padding(.top, 10)
                    .onTapGesture {
                        self.contentViewDataModel.menuIsShown = true
                        self.recipeDataModel.hideViews()
                    }
                                
                Text(title)
                    .padding(.leading, 20).padding(.bottom, -25)
                    .padding(.top, 10)
                    .font(.custom("HelveticaNeue-Bold", size: 36))
                    .foregroundColor(Color.white)
                
                Spacer()
                
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
            .frame(height: 130)
        }
        .background(Color("TealBackground"))
        .cornerRadius(20)
        .shadow(color: colorScheme == .dark ? .clear : Color("Dark-Gray") , radius: 4)
    }
}
