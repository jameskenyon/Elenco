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
    public func fetchIngredients(completion: @escaping (Error?)->()) {
        DispatchQueue.global().async {
            let request: NSFetchRequest<IngredientStore> = IngredientStore.fetchRequest()
            do {
                let ingredientsEntities = try self.context.fetch(request)
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
            let ingredientsEntities = try self.context.fetch(request)
            return ingredientsEntities.map({ Ingredient(ingredientStore: $0) })
        }
        catch {
            return []
        }
    }
    
    // MARK: - Update Methods
    
    // Save Ingredient to core data model
    public func save(ingredient: Ingredient, completion: @escaping (Error?) -> ()) {
        let ingredientStore = IngredientStore(context: self.context)
        ingredientStore.ingredientID = ingredient.ingredientID
        ingredientStore.name         = ingredient.name
        ingredientStore.aisle        = ingredient.aisle
        ingredientStore.quantity     = ingredient.quantity
        ingredientStore.completed    = ingredient.completed
        ingredientStore.list = ElencoListDataModel().getListStore(forName: ingredient.parentList?.name ?? "")
        
        do {
            try self.context.save()
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
            guard let ingredientsEntity = try self.context.fetch(request).first else { return }
            ingredientsEntity.setValue(ingredient.completed, forKey: "completed")
            ingredientsEntity.setValue(ingredient.quantity, forKey: "quantity")
            ingredientsEntity.setValue(ingredient.name, forKey: "name")
            ingredientsEntity.setValue(ingredient.aisle, forKey: "aisle")
            try self.context.save()
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
            guard let ingredientsEntity = try self.context.fetch(request).first else { return }
            self.context.delete(ingredientsEntity)
            try self.context.save()
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
            let ingredientsStores = try self.context.fetch(request)
            if let allList = ElencoListDataModel().getListStore(forName: ElencoDefaults.mainListName) {
                for store in ingredientsStores {
                    if store.list == nil {
                        store.setValue(allList, forKey: "list")
                    }
                    if store.ingredientID == nil {
                        store.setValue(UUID(), forKey: "ingredientID")
                    }
                }
            }
            try self.context.save()
        } catch {}
    }

}
