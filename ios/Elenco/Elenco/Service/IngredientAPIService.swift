//
//  IngredientAPIService.swift
//  Elenco
//
//  Created by James Kenyon on 27/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation

internal class IngredientAPIService {
    
    // save all the ingredients
    private static var ingredientCache: [String: Ingredient] = [:]
    // save ingredient search results
    private static var ingredientListCache: [String: Ingredients] = [:]
    // save the most recent api request query
    private static var mostRecentAPIQuery: String = ""
    
    // MARK: Public Interface
    
    /*
     Load all of the ingredients into the app (use background thread)
     */
    static func configureIngredientCache() {
        DispatchQueue.global().async {
            if let path = Bundle.main.path(forResource: "IngredientData", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    if let jsonResult = jsonResult as? [[String: AnyObject]] {
                        for ingredient in jsonResult {
                            if let name = ingredient["name"] as? String,
                                let id = ingredient["id"] as? Int,
                                let aisle = ingredient["aisle"] as? String {
                                ingredientCache[name] = Ingredient(name: name, id: id, aisle: aisle)
                            }
                        }
                    }
                } catch {
                    return // don't handle error
                }
            }
        }
    }
    
    /*
        Return all the possible ingredients for a given search
        Param:
            query - the name that of the ingredient that the user is searching for
            numResults - the number of results to return
     */
    static func getPossibleIngredientsFor(query: String, numResults: Int = 5) -> Ingredients {
        var returnIngredients: Ingredients = []
        if let cachedList = ingredientListCache[query] {
            return cachedList
        } else {
            for key in ingredientCache.keys {
                if returnIngredients.count == numResults {
                    break
                }
                if key.contains(query.lowercased()) {
                    if let ingredient = ingredientCache[key] {
                        returnIngredients.append(ingredient)
                    }
                }
            }
            mostRecentAPIQuery = query
            ingredientListCache[query] = returnIngredients
        }
        return returnIngredients
    }
    
    /*/
        Return the Aisle that the ingredient belongs to, if nothing can be found then use
        nil.
        Param:
            ingredientName - the name of the ingredient
            completion - the completion closure that will contain the name of the aisle that the
                         ingredient belongs to.
     */
    public static func getAisleForIngredient(ingredientName: String) -> String {
        if let aisle = ingredientCache[ingredientName.lowercased()]?.aisle {
            return aisle
        }
        return "Other"
    }
    
    // MARK: Private Interface
    
    /*
     Save the new values to the ingredient cache
     */
    private static func updateIngredientCache(ingredients: Ingredients) {
        for ingredient in ingredients {
            self.ingredientCache[ingredient.name] = ingredient
        }
    }

}

// MARK: Example Calls

// GET POSSIBLE INGREDIENTS FOR QUERY
/*
IngredientAPIService.getPossibleIngredientsFor(query: "Carr", completion: { (ingredients) in
    for ingredient in ingredients{
        print(ingredient.name)
    }
})
*/
