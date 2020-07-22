//
//  IngredientAPIService.swift
//  Elenco
//
//  Created by James Kenyon on 27/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation

/**
 The Ingredient Service interfaces with the ingredientData.json file to load the ingredients.
 
 The IngredientAPIService is responsible for loading all of the ingredients into the app from the json file.
 All the information on the ingredients is stored in this file and are loaded into the current session when the
 app loads.
 
 - Author: James Kenyon
 */

internal class IngredientAPIService {
    
    // MARK: Properties
    
    /// The cache where all the ingredients are stored..
    private static var ingredientCache: [String: Ingredient] = [:]
    /// Save all ingredient search results in this cache.
    private static var ingredientListCache: [String: Ingredients] = [:]
    
    // MARK: Public Interface
    
    /**
     Load all of the ingredients into the app.
     
     Called when the app loads, this method uses a background thread to populate all of the ingredient
     information into the ingredientCache.
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
                                let aisle = ingredient["aisle"] as? String {
                                ingredientCache[name] = Ingredient(ingredientID: UUID(), name: name, aisle: aisle, parentList: nil)
                            }
                        }
                    }
                } catch {
                    return // don't handle error
                }
            }
        }
    }
    
    /**
     Get all of the possible ingredients matching a query.
     
     This method can be used to get the ingredients whose name's contain a substring of the query.
     
     - Parameters:
        - query: The query that the user wants to search based on.
        - numResults: The max number of ingredients to be returned in one call.
     
     - Returns: An array of ingredients whose name's  match the given query.
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
            ingredientListCache[query] = returnIngredients
        }
        return returnIngredients
    }
    
    /**
     Get an aisle for an ingredient by name.
     
     - Parameters:
        - ingredientName: The name of the ingredient to get the aisle for.
     
     - Returns: The name of the aisle as a String.
     */
    public static func getAisleForIngredient(ingredientName: String) -> String {
        var name = ingredientName.lowercased()
        if let aisle = ingredientCache[name]?.aisle {
            return formattedAisle(aisle: aisle)
        } else {
            // check if ending has ies. For example: berry = berries
            if name.hasSuffix("ies") {
                if let aisle = ingredientCache[name.replacingOccurrences(of: "ies", with: "y")]?.aisle {
                    return formattedAisle(aisle: aisle)
                }
            }
            // check if last letter is 's'
            if ingredientName.count >= 2 {
                name.removeLast()
                if let aisle = ingredientCache[name]?.aisle {
                    return formattedAisle(aisle: aisle)
                }
            }
        }
        return "Other"
    }
    
    // MARK: Private Interface
    
    /**
     Format the aisle name.
     
     Sometimes the aisle contains ; which separates aisle types if an ingredient falls into
     different categories.
     
     - Parameter aisle: The unformatted aisle string.
     
     - Returns: The formatted aisle string.
     */
    private static func formattedAisle(aisle: String) -> String {
        let segments = aisle.split(separator: ";")
        if let seg = segments.first {
            return String(seg)
        }
        return aisle
    }

}
