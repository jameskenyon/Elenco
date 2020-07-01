//
//  IngredientDataModel.swift
//  Elenco
//
//  Created by James Bernhardt on 30/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import CoreData
import SwiftUI
import UIKit

class IngredientDataModel: ObservableObject {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var ingredients = Ingredients()
    
    // Fetch Ingredients
    public func fetchIngredients(completion: (Error?)->()) {
        let request: NSFetchRequest<IngredientData> = IngredientData.fetchRequest()
        
        do {
            let ingredientsEntities = try context.fetch(request)
            self.ingredients = ingredientsEntities.map({ $0.ingredientFromSelf() })
            completion(nil)
        } catch (let error) {
            completion(error)
        }
    }
    
    // Save Ingredient to core data model
    public func save(ingredient: Ingredient, completion: (Error?) -> ()) {
        let ingredientData = IngredientData(context: context)
        ingredientData.name     = ingredient.name
        ingredientData.aisle    = ingredient.aisle
        ingredientData.quantity = ingredient.quantity

        do {
            try context.save()
            completion(nil)
        } catch (let error) {
            completion(error)
        }
    }
}
