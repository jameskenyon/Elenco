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
    
    private static var ingredientListCache: [String: Ingredients] = [:]
    private static var mostRecentAPIQuery: String = ""
    
    // MARK: Public Interface
    
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
                                completion(ingredients)
                            }
                        }
                    }
                })
                dataTask.resume()
            }
        }
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
