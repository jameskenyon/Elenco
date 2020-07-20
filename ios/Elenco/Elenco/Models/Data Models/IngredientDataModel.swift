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
    
    public static let shared = IngredientDataModel()
    
    // MARK: - Properties
    @Published var ingredients = Ingredients()
    
    // MARK: - Fetch Methods
    
    // Fetch Ingredients
    public func fetchIngredients(completion: @escaping (Error?)->()) {
        DispatchQueue.global().async {
            let request: NSFetchRequest<IngredientStore> = IngredientStore.fetchRequest()
            do {
                let ingredientsEntities = try ElencoDefaults.context.fetch(request)
                self.ingredients = ingredientsEntities.map({ Ingredient(ingredientStore: $0) })
                completion(nil)
            } catch (let error) {
                completion(error)
            }
        }
    }
    
    public func fetchIngredients() -> Ingredients {
        let request: NSFetchRequest<IngredientStore> = IngredientStore.fetchRequest()
        do {
            let ingredientsEntities = try ElencoDefaults.context.fetch(request)
            let ingredients = ingredientsEntities.map({ Ingredient(ingredientStore: $0) })
            self.ingredients = ingredients
            return ingredients
        }
        catch {
            return []
        }
    }
    
    // MARK: - Update Methods
    
    // Save Ingredient to core data model
    public func save(ingredient: Ingredient, completion: @escaping (Error?) -> ()) {
        let ingredientStore = IngredientStore(context: ElencoDefaults.context)
        ingredientStore.ingredientID = ingredient.ingredientID
        ingredientStore.name         = ingredient.name
        ingredientStore.aisle        = ingredient.aisle
        ingredientStore.quantity     = ingredient.quantity
        ingredientStore.completed    = ingredient.completed
        if let parentList = ingredient.parentList {
            ingredientStore.list = ElencoListDataModel.shared.getListStore(forID: parentList.listID)
        }
        
        do {
            try ElencoDefaults.context.save()
            completion(nil)
        } catch (let error) {
            completion(error)
        }
    }
    
    // Update the completion of a ingredient
    public func update(ingredient: Ingredient, completion: @escaping (Error?)->()) {
        let request: NSFetchRequest<IngredientStore> = IngredientStore.fetchRequest()
        request.predicate = NSPredicate(format: "ingredientID == %@", ingredient.ingredientID as CVarArg)
        do {
            guard let ingredientsEntity = try ElencoDefaults.context.fetch(request).first else { return }
            ingredientsEntity.setValue(ingredient.completed, forKey: "completed")
            ingredientsEntity.setValue(ingredient.quantity, forKey: "quantity")
            ingredientsEntity.setValue(ingredient.name, forKey: "name")
            ingredientsEntity.setValue(ingredient.aisle, forKey: "aisle")
            try ElencoDefaults.context.save()
            completion(nil)
        } catch (let error) {
            completion(error)
        }
    }
    
    // Delete ingredient from data model
    public func delete(ingredient: Ingredient, completion: @escaping (Error?)->()) {
        let request: NSFetchRequest<IngredientStore> = IngredientStore.fetchRequest()
        request.predicate = NSPredicate(format: "ingredientID == %@", ingredient.ingredientID as CVarArg)
        do {
            guard let ingredientsEntity = try ElencoDefaults.context.fetch(request).first else { return }
            ElencoDefaults.context.delete(ingredientsEntity)
            try ElencoDefaults.context.save()
            completion(nil)
        } catch (let error) {
            completion(error)
        }
    }
    
    // update the ingredients in the list so that if they have
    // a parent list type of null, they will be assigned to the 'All' list.
    public func updateIngredientListIfRequired() {
        let request: NSFetchRequest<IngredientStore> = IngredientStore.fetchRequest()
        do {
            let ingredientsStores = try ElencoDefaults.context.fetch(request)
            if let allList = ElencoListDataModel.shared.getListStore(forName: ElencoDefaults.mainListName) {
                for store in ingredientsStores {
                    if store.list == nil {
                        store.setValue(allList, forKey: "list")
                    }
                    if store.ingredientID == nil {
                        store.setValue(UUID(), forKey: "ingredientID")
                    }
                }
            }
            try ElencoDefaults.context.save()
        } catch {}
    }

}
