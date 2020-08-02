//
//  RecipeDataModel.swift
//  Elenco
//
//  Created by James Kenyon on 01/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import CoreData

/**
 The RecipeDataModel class is responsible for fetching and saving all of the user's
 recipes with CoreData.
 
 - Author: James Kenyon
*/

class RecipeDataModel: ObservableObject {

    /// The shared instance of RecipeDataModel
    public static let shared = RecipeDataModel()
    
    // MARK: Properties
    
    /// An array of the users current recipes.
    @Published var recipes = Recipes()
    
    // MARK: Public Interface
    
    /**
     Fetch Recipes from core data.
     
     -  Parameter completion: A completion block with the errors (if any)
     */
    public func fetchRecipes(completion: @escaping (Error?)->()) {
        DispatchQueue.global().async {
            let request: NSFetchRequest<RecipeStore> = RecipeStore.fetchRequest()
            do {
                let recipeEntities = try ElencoDefaults.context.fetch(request)
                self.recipes = recipeEntities.map({ Recipe(recipeStore: $0) })
                completion(nil)
            } catch (let error) {
                completion(error)
            }
        }
    }
    
    /**
     Fetch Recipes from core data (that the user has saved) and return.
    
     - Important: This method also updates the local recipes property
    
     - Returns: An array of recipes, empty if none are found.
     */
    public func fetchRecipes() -> Recipes {
        let request: NSFetchRequest<RecipeStore> = RecipeStore.fetchRequest()
        do {
            let recipeEntities = try ElencoDefaults.context.fetch(request)
            let recipes = recipeEntities.map({ Recipe(recipeStore: $0) })
            self.recipes = recipes
            return recipes
        }
        catch {
            return []
        }
    }
    
    /**
     Create a new recipe from scratch.
     
     - Parameters:
        - recipe: The recipe to create.
        - completion: The completion handler.
     */
    public func createRecipe(recipe: Recipe, completion: @escaping (Error?) -> ()) {
        let recipeStore = RecipeStore(context: ElencoDefaults.context)
        recipeStore.name = recipe.name
        recipeStore.id = recipe.id
        recipeStore.recipeID = recipe.recipeID
        recipeStore.serves = Int16(recipe.serves)
        recipeStore.isShared = recipe.isSharedRecipe
        recipeStore.estimatedTime = recipe.estimatedTime
        recipeStore.dietaryRequirements = recipe.dietaryRequirements
        recipeStore.image = recipe.image?.pngData()
        recipeStore.ingredients = recipe.getIngredientsAsJSONString()
        recipeStore.method = recipe.getMethodAsJSONString()
        do {
            try ElencoDefaults.context.save()
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    /**
     Update a recipe
     
     - Parameters:
        - recipe: The new recipe to update.
        - compltion: Error completion handler.
     */
    public func update(recipe: Recipe, completion: @escaping (Error?)->()) {
        let request: NSFetchRequest<RecipeStore> = RecipeStore.fetchRequest()
        request.predicate = NSPredicate(format: "recipeID == %@", recipe.recipeID as CVarArg)
        do {
            guard let recipeEntity = try ElencoDefaults.context.fetch(request).first else { return }
            recipeEntity.setValue(recipe.name, forKey: "name")
            recipeEntity.setValue(recipe.serves, forKey: "serves")
            recipeEntity.setValue(recipe.isSharedRecipe, forKey: "isShared")
            recipeEntity.setValue(recipe.estimatedTime, forKey: "estimatedTime")
            recipeEntity.setValue(recipe.dietaryRequirements, forKey: "dietaryRequirements")
            recipeEntity.setValue(recipe.image?.pngData(), forKey: "image")
            recipeEntity.setValue(recipe.getIngredientsAsJSONString(), forKey: "ingredients")
            recipeEntity.setValue(recipe.getMethodAsJSONString(), forKey: "method")
            try ElencoDefaults.context.save()
            completion(nil)
        } catch (let error) {
            completion(error)
        }
    }

    /**
     Delete a recipe
     
     - Parameters:
        - ingredient: The recipe to delete.
        - compltion: Error completion handler.
     */
    public func delete(recipe: Recipe, completion: @escaping (Error?)->()) {
        let request: NSFetchRequest<RecipeStore> = RecipeStore.fetchRequest()
        request.predicate = NSPredicate(format: "recipeID == %@", recipe.recipeID as CVarArg)
        do {
            guard let recipesEntity = try ElencoDefaults.context.fetch(request).first else { return }
            ElencoDefaults.context.delete(recipesEntity)
            try ElencoDefaults.context.save()
            completion(nil)
        } catch (let error) {
            completion(error)
        }
    }
    
}
