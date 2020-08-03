//
//  RecipeHolderDataModel.swift
//  Elenco
//
//  Created by James Bernhardt on 01/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

class RecipeHolderDataModel: ObservableObject {
    
    @Published var editRecipiesIsShown: Bool = false
    
    // Return ingredients sorted into alphabetical sections
    public func ingredientsSortedByName(recipe: Recipe) -> [RecipeListViewSection<Ingredient>] {
        let ingredients = recipe.ingredients
        var sections = [RecipeListViewSection<Ingredient>]()
        let sectionHeaders = Set(ingredients.map({ $0.name.first?.lowercased() ?? ""}))
        
        // Filter ingredients in each section
        for header in sectionHeaders {
            let ingredientsInSection = ingredients.filter({ $0.name.first?.lowercased() ?? "" == header })
            let section = RecipeListViewSection<Ingredient>(title: String(header), content: ingredientsInSection)
            sections.append(section)
        }
        sections = sections.sorted(by: { $0.title < $1.title })
        return sections
    }
    
    // Return Methods sorted into sectinos
    public func methodsSortedIntoSections(recipe: Recipe) -> [RecipeListViewSection<RecipeMethod>] {
        
        let methods = recipe.method
        var sections = [RecipeListViewSection<RecipeMethod>]()
        for method in methods {
            let section = RecipeListViewSection<RecipeMethod>(title: "\(method.number)", content: [method])
            sections.append(section)
        }
        return sections
    }
}

