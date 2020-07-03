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

/*
 This class is responsible for fetching and saving all of the user's
 ingredients with CoreData.
 */

class IngredientDataModel: ObservableObject {
    
    // MARK: - Properties
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @Published var ingredients = Ingredients()
    
    // MARK: - Fetch Methods
    
    // Fetch Ingredients
    public func fetchIngredients(completion: (Error?)->()) {
        let request: NSFetchRequest<IngredientStore> = IngredientStore.fetchRequest()
        do {
            let ingredientsEntities = try context.fetch(request)
            self.ingredients = ingredientsEntities.map({ Ingredient(ingredientStore: $0) })
            completion(nil)
        } catch (let error) {
            completion(error)
        }
    }
    
    // MARK: - Update Methods
    
    // Save Ingredient to core data model
    public func save(ingredient: Ingredient, completion: (Error?) -> ()) {
        let ingredientStore = IngredientStore(context: context)
        ingredientStore.name      = ingredient.name
        ingredientStore.aisle     = ingredient.aisle
        ingredientStore.quantity  = ingredient.quantity
        ingredientStore.completed = ingredient.completed

        do {
            try context.save()
            completion(nil)
        } catch (let error) {
            completion(error)
        }
    }
    
    // Update the completion of a ingredient
    public func update(ingredient: Ingredient, completion: (Error?)->()) {
        let request: NSFetchRequest<IngredientStore> = IngredientStore.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", ingredient.name)
        
        do {
            guard let ingredientsEntity = try context.fetch(request).first else { return }
            ingredientsEntity.setValue(ingredient.completed, forKey: "completed")
            try context.save()
            completion(nil)
        } catch (let error) {
            completion(error)
        }
    }
    
    // Delete ingredient from data model
    public func delete(ingredient: Ingredient, completion: (Error?)->()) {
        let request: NSFetchRequest<IngredientStore> = IngredientStore.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", ingredient.name)
        do {
            guard let ingredientsEntity = try context.fetch(request).first else { return }
            context.delete(ingredientsEntity)
            try context.save()
            completion(nil)
        } catch (let error) {
            completion(error)
        }
    }
}
