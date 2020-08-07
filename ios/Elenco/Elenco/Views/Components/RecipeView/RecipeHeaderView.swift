//
//  RecipeHeaderView.swift
//  Elenco
//
//  Created by James Bernhardt on 01/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct RecipeHeaderView: View {
    
    @EnvironmentObject var listDataModel: ListHolderDataModel
    @EnvironmentObject var recipeDataModel: RecipeHolderDataModel
    @EnvironmentObject var contentDataModel: ContentViewDataModel
    
    var image: UIImage?
    var geometry: GeometryProxy
    
    var body: some View {
            ZStack(alignment: .top) {
                if self.image != nil {
                    Image(uiImage: self.image!)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .colorMultiply(.gray)
                        .frame(width: geometry.size.width, height: headerViewHeight)
                        .cornerRadius(headerViewCornerRadius)
                        .overlay(
                            self.headerBody(for: geometry.size)
                        )
                } else {
                    RoundedRectangle(cornerRadius: headerViewCornerRadius)
                        .frame(width: geometry.size.width, height: headerViewHeight)
                        .foregroundColor(Color("Light-Gray"))
                        .overlay(
                            self.headerBody(for: geometry.size)
                        )
                }
            }
    }
    
    func headerBody(for size: CGSize) -> some View {
        VStack {
            HStack {
                Text("Back")
                    .onTapGesture {
                        self.backButtonPressed()
                    }
                    .font(.custom("HelveticaNeue-Bold", size: 20))
                Spacer()
            }
            .padding(.top, menuIconTop + 30)
            .padding(.leading)
            
            Text(recipeDataModel.selectedRecipe.name.capitalized)
                .font(.custom("HelveticaNeue-Bold", size: 35))
                .padding(.bottom, -10)
                .padding(.top, 45)
            Rectangle()
                .frame(width: underLineWidth(for: size), height: 2)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("\(recipeDataModel.selectedRecipe.ingredients.count) Ingredients")
                    Text("Estimated time: \(recipeDataModel.selectedRecipe.estimatedTime)")
                }
                Spacer()
            }
            .font(.custom("HelveticaNeue-Bold", size: 20))
            .padding(.leading, 20)
            .padding(.top)
            
            HStack {
                RecipeButton(title: "Edit", color: Color("Teal"), width: buttonWidth(for: size)) {
                    self.editButtonTapped()
                }
                
                RecipeButton(title: "Delete", color: Color(#colorLiteral(red: 0.9647058824, green: 0.5058823529, blue: 0.137254902, alpha: 1)), width: buttonWidth(for: size)) {
                    self.deleteButtonTapped()
                }
                .padding(.leading, 5)
                Spacer()
            }
            .padding(.top, buttonTop)
            .padding(.leading, 20)
        }
        .foregroundColor(Color.white)
    }
    
    // MARK: - Button Actions
    private func editButtonTapped() {
        recipeDataModel.configureSelectedRecipe(for: recipeDataModel.selectedRecipe)
        recipeDataModel.displayEditRecipeView()
    }
    
    private func deleteButtonTapped() {
        listDataModel.window.displayAlert(title: "Delete Recipe", message: "Are you sure you want to delete this recipe?", okTitle: "Delete") { (_) -> (Void) in
            self.recipeDataModel.deleteRecipe()
            self.recipeDataModel.hideViews()
        }
    }
    
    private func backButtonPressed() {
        recipeDataModel.hideViews()
    }
    
    // MARK: - View Constants
    
    private var headerViewHeight: CGFloat {
        return 380
    }
    
    private var headerViewCornerRadius: CGFloat {
        return 20
    }
    
    private var menuIconTop: CGFloat {
        return geometry.safeAreaInsets.top
    }
    
    private func underLineWidth(for size: CGSize) -> CGFloat {
        return size.width * 0.2
    }
    
    private func buttonWidth(for size: CGSize) -> CGFloat {
        return size.width * 0.25
    }
    
    private var buttonTop: CGFloat {
        return 25
    }
}
