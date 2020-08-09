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
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        VStack {
            if recipeViewDataModel.editRecipiesIsShown {
                RecipesHeaderView(isEditList: true, title: recipeViewDataModel.isNewRecipe ? "Add Recipe" : "Edit Recipe")
                EditRecipeView()
            } else if recipeViewDataModel.recipeViewIsShown {
                RecipeView()
            } else {
                RecipesHeaderView(title: "My Recipes")
                if recipeViewDataModel.recipes.isEmpty {
                    RecipeListTutorialView().padding(.horizontal)
                } else {
                    listView()
                    .onTapGesture {
                        self.recipeViewDataModel.recipeSearchIsFirstResponder = false
                    }
                }
                AddRecipeButton()
                    .padding(.bottom, getBottomElementPadding())
            }               
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    // MARK: - Recipe List View
    public func listView() -> some View {
        List {
            Section(header:
                // Search view
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color("Background"))
                        .shadow(color: Color("Light-Gray").opacity(0.5), radius: 5, y: 3)
                        .frame(height: 60)
                    
                    ElencoTextField(text: $searchText, isFirstResponder: recipeViewDataModel.recipeSearchIsFirstResponder, textFieldView: self, font: UIFont(name: "HelveticaNeue-Medium", size: 20), color: UIColor.black, placeholder: "Search recipes...")
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
                    ElencoSectionHeader(title: section.title)
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
                    self.recipeViewDataModel.recipeSearchIsFirstResponder = false
                }
        )
    }
    
    // Work out which section and row recipe is in and remove from list
    func removeRecipe(atSection section: ListViewSection<Recipe>, index: Int) {
        let selectedSection = sections().filter({ $0.title == section.title}).first
        if let recipe = selectedSection?.content[index] {
            self.recipeViewDataModel.delete(recipe: recipe)
        }
    }
    
    func sections() -> [ListViewSection<Recipe>] {
        let recipes = recipeViewDataModel.search(text: searchText)
        return recipeViewDataModel.recipeSections(for: recipes)
    }
    
    // MARK: - Text Field Delegate Methods
    func userDidReturnOnTextField() {
        recipeViewDataModel.recipeSearchIsFirstResponder = false
    }
    
    func userDidEditTextField(newValue: String) {}
}

// The add recipe button
struct AddRecipeButton: View {
    
    @EnvironmentObject var recipeViewDataModel: RecipeHolderDataModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Button(action: {
            withAnimation {
                self.recipeViewDataModel.displayEditRecipeView()
                self.recipeViewDataModel.configureNewSelectedRecipe()
            }
         }, label: {
            Text("+")
                .font(.custom("HelveticaNeue-Bold", size: 50))
                .foregroundColor(Color.white)
                .padding(.bottom, 10)
        })
        .buttonStyle(OrangeCircleButtonStyle())
        .shadow(color: colorScheme == .dark ? .clear : Color("Light-Gray").opacity(0.4) , radius: 4)
    }
    
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesListView()
    }
}
