//
//  IngredientAPIService.swift
//  Elenco
//
//  Created by James Kenyon on 27/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation

internal class IngredientAPIService {
    
    // API Information
    private static let autocompleteAddress = "https://api.spoonacular.com/food/ingredients/autocomplete"
    private static let apiKey = "85c4130102284fe0ad261a1cb5dd5551"
    
    // save [IngredientName:Ingredient]
    private static var ingredientCache: [String: Ingredient] = [:]
    // save [IngredientSearch: Ingredients]
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
                    print("Error")
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
    static func getPossibleIngredientsFor(query: String, numResults: Int = 5, completion: @escaping (Ingredients)->()) {
        if let cachedList = ingredientListCache[query] {
            completion(cachedList)
        } else {
            if query.count >= 5 {
                completion(getPossibleIngredientsForQueryFromCache(shortQuery: mostRecentAPIQuery, fullQuery: query))
            } else {
                let formattedQuery = query.replacingOccurrences(of: " ", with: "%20")
                let url = "\(autocompleteAddress)?apiKey=\(apiKey)&query=\(formattedQuery)&number=\(numResults)&metaInformation=true"
                guard let nsUrl = NSURL(string: url) else {
                    completion([])
                    return
                }
                let request = NSMutableURLRequest(url: nsUrl as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
                let session = URLSession.shared
                let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                    if (error != nil) {
                        completion([])
                    } else {
                        if let data = data {
                            if let ingredients = try? JSONDecoder().decode(Ingredients.self, from: data) {
                                // save details to cache and memory before returning
                                mostRecentAPIQuery = query
                                ingredientListCache[query] = ingredients
                                updateIngredientCache(ingredients: ingredients)
                                completion(ingredients)
                            }
                        }
                    }
                })
                dataTask.resume()
            }
        }
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
     Limit the requests being sent to the api by searching through the cache.
     */
    private static func getPossibleIngredientsForQueryFromCache(shortQuery:String, fullQuery: String) -> Ingredients {
        guard let ingredients = ingredientListCache[shortQuery] else {
            return []
        }
        var returnIngredients: Ingredients = []
        for ingredient in ingredients {
            if ingredient.name.lowercased().contains(fullQuery.lowercased()) {
                returnIngredients.append(ingredient)
            }
        }
        return returnIngredients
    }
    
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
