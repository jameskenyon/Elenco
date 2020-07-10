//
//  ElencoListDataModel.swift
//  Elenco
//
//  Created by James Kenyon on 09/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ElencoListDataModel: ObservableObject {

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @Published var lists: [ElencoList] = []

    // MARK: Fetch Methods available to public
    
    // create a new list from scratch
    public func createList(list: ElencoList, completion: @escaping (Error?) -> ()) {
        let listStore = ListStore(context: self.context)
        listStore.id       = UUID()
        listStore.name     = list.name
        listStore.isShared = list.isSharedList
        listStore.ingredients = []
        do {
            try self.context.save()
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    // get individual list - nil if list not found
    public func getList(listName: String) -> ElencoList? {
        let listStore = getListStore(forName: listName)
        if let listStore = listStore {
            return getListFromStore(listStore: listStore)
        }
        return nil
    }
    
    // get all of the lists and their ingredients
    public func getLists() -> [ElencoList] {
        let request: NSFetchRequest<ListStore> = ListStore.fetchRequest()
        do {
            let listStores = try self.context.fetch(request)
            var returnLists:[ElencoList] = []
            for store in listStores {
                returnLists.append(
                    getListFromStore(listStore: store)
                )
            }
            return returnLists
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    // get a list store object for when the user needs to save
    // the list to memory
    public func getListStore(forName name: String) -> ListStore? {
        let request: NSFetchRequest<ListStore> = ListStore.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        do {
            guard let listEntity = try self.context.fetch(request).first else { return nil }
            return listEntity
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    // MARK: Private helper methods
    
    /*
    // ⚠️ get list object by using an id and update the other methods as required
    public func getListStore(forID id: String) -> ListStore? {
        let request: NSFetchRequest<ListStore> = ListStore.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", id)
        do {
            guard let listEntity = try self.context.fetch(request).first else { return nil }
            return listEntity
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    */
    
    // get list from store
    private func getListFromStore(listStore: ListStore) -> ElencoList {
        let ingredientStores = listStore.ingredients?.allObjects ?? []
        var ingredients: Ingredients = []
        for store in ingredientStores {
            if let store = store as? IngredientStore {
                ingredients.append(
                    Ingredient(ingredientStore: store)
                )
            }
        }
        return ElencoList(name: listStore.name ?? "", id: listStore.id ?? UUID(), ingredients: ingredients)
    }
    
}
