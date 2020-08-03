//
//  RecipeIngredientMethodPagerView.swift
//  Elenco
//
//  Created by James Bernhardt on 01/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct IngredientMethodPagerView: View {
    
    @EnvironmentObject var recipeHolderDataModel: RecipeHolderDataModel
    var recipe: Recipe
    @State var currentIndex = 0
    var addIngredientAction: (()->())?
    var saveIngredientActoin: (()->())?
    var addMethodAction: (()->())?
    var saveMethodAction: (()->())?
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Button(action: {
                        self.currentIndex = 0
                    }) {
                        Text("Ingredients")
                            .scaleEffect(self.currentIndex == 0 ? 1 : 0.7)
                            .foregroundColor(self.currentIndex == 0 ? Color("Lead") : Color("Dark-Gray"))
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.currentIndex = 1
                    }) {
                        Text("Method")
                            .scaleEffect(self.currentIndex == 1 ? 1 : 0.7)
                        .foregroundColor(self.currentIndex == 1 ? Color("Lead") : Color("Dark-Gray"))
                    }
                }
                .font(.custom("HelveticaNeue-Bold", size: 25))
                .animation(.easeInOut(duration: 0.2))
                .padding(.horizontal, self.pagerButtonHorizontalPaddig)
                .padding(.top)
                
                HStack {
                    Rectangle()
                        .foregroundColor(Color("Teal"))
                        .frame(width: self.underlineWidth(for: geometry.size), height: 4)
                        .offset(x: self.underlineOffsetX(for: geometry.size), y: 0)
                        .animation(.spring())
                    Spacer()
                }
                
                ElencoPagerView(pageCount: 2, currentIndex: self.$currentIndex, showsPageIndicator: false) {
                    RecipeIngredientListView(sections: self.recipeHolderDataModel.ingredientsSortedByName(recipe: self.recipe),
                                             addAction: self.addIngredientAction,
                                             saveAction: self.saveIngredientActoin)
                    
                    RecipeIngredientListView(sections: self.recipeHolderDataModel.methodsSortedIntoSections(recipe: self.recipe),
                                             addAction: self.addMethodAction,
                                             saveAction: self.saveMethodAction)
                }
                .padding(.top)
            }
        }
    }
    
    // MARK: - View Constants
    func underlineWidth(for size: CGSize) -> CGFloat {
        if currentIndex == 0 {
            return 150
        }
        return 100
    }
    
    func underlineOffsetX(for size: CGSize) -> CGFloat {
        if currentIndex == 0 {
            return pagerButtonHorizontalPaddig
        }
        return size.width - underlineWidth(for: size) - pagerButtonHorizontalPaddig
    }
    
    var pagerButtonHorizontalPaddig: CGFloat {
        return 30
    }
}
