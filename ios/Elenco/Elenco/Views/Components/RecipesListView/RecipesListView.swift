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
                Section(header:
                    // Search view
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Color("Background"))
                        .shadow(color: Color("Light-Gray"), radius: 5)
                            .frame(height: 50)
                        
                        ElencoTextField(text: $searchText, isFirstResponder: searchTextFieldIsFirstResponder, textFieldView: self, font: UIFont(name: "HelveticaNeue-Regular", size: 20), color: UIColor.black, placeholder: "Search your recipes")
                            .accentColor(Color("Teal"))
                            .foregroundColor(Color("BodyText"))
                            .padding(.leading)
                    }
                    .padding(.bottom)
                    ) {
                        EmptyView()
                    }
                
                
                // Recipes
                ForEach(sections(), id: \.title) { section in
                    Section(header:
                        IngredientSectionHeader(title: section.title)
                            .padding(.top, -18)
                    ) {
                        ForEach(section.content) { recipe in
                            RecipeListCell(recipe: recipe)
                            .onTapGesture {
                                self.recipeViewDataModel.displayRecipeView()
                                self.recipeViewDataModel.configureSelectedRecipe(for: recipe)
                            }
                        }
                        .onDelete { (indexSet) in
                            guard let index = indexSet.first else { return }
                            self.removeRecipe(atSection: section, index: index)
                        }
                    }
                }

            }
            .listStyle(GroupedListStyle())
            .gesture(
                DragGesture()
                    .onChanged { _ in
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
    
    // Work out which section and row recipe is in and remove from list
    func removeRecipe(atSection section: RecipeListViewSection<Recipe>, index: Int) {
        let selectedSection = sections().filter({ $0.title == section.title}).first
        if let recipe = selectedSection?.content[index] {
            self.recipeViewDataModel.delete(recipe: recipe)
        }
    }
    
    func sections() -> [RecipeListViewSection<Recipe>] {
        let recipes = recipeViewDataModel.search(text: searchText)
        return recipeViewDataModel.recipeSections(for: recipes)
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
