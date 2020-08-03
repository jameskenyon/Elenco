//
//  RecipesView.swift
//  Elenco
//
//  Created by James Bernhardt on 01/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct RecipesListView: View, ElencoTextFieldDisplayable {
        
    @EnvironmentObject var contentViewDataModel: ContentViewDataModel
    @EnvironmentObject var recipeViewDataModel: RecipeHolderDataModel
    @State var searchText: String = ""
    @State var searchTextFieldIsFirstResponder: Bool = false
    
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
                .onTapGesture {
                    self.searchTextFieldIsFirstResponder = false
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    // MARK: - Recipe List View
    public func listView() -> some View {
        ZStack(alignment: .center) {
            List {
                // Search view
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color("Background"))
                    .shadow(color: Color("Light-Gray"), radius: 5)
                        .frame(height: 50)
                    
                    ElencoTextField(text: $searchText, isFirstResponder: searchTextFieldIsFirstResponder, textFieldView: self, font: UIFont(name: "HelveticaNeue-Regular", size: 20), color: UIColor.black, placeholder: "Search your recipes")
                        .accentColor(Color("Teal"))
                        .foregroundColor(Color("BodyText"))
                        .padding(.leading)
                }
                .padding(.bottom)
                
                
                // Recipes
                ForEach(recipeViewDataModel.search(text: searchText)) { recipe in
                    RecipeListCell(recipe: recipe)
                        .onTapGesture {
                            self.recipeViewDataModel.displayRecipeView()
                            self.recipeViewDataModel.configureSelectedRecipe(for: recipe)
                        }
                }
                .onDelete { (indexSet) in
                    guard let index = indexSet.first else { return }
                    self.removeRecipe(index: index)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { _ in
                        print("Drag")
                        self.searchTextFieldIsFirstResponder = false
                    }
            )
            // Add Button
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
    
    // Work out which section and row ingredient is in and remove from list
    func removeRecipe(index: Int) {
        let recipe = recipeViewDataModel.recipes[index]
//        recipeViewDataModel.configureSelectedRecipe(for: recipe)
//        recipeViewDataModel.deleteRecipe()
        recipeViewDataModel.delete(recipe: recipe)
    }
    
    // MARK: - Text Field Delegate Methods
    func userDidReturnOnTextField() {
        searchTextFieldIsFirstResponder = false
    }
    
    func userDidEditTextField(newValue: String) {}
}


struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesListView()
    }
}
