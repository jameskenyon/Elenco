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
    
    @Published var selectedList: ElencoList?
    
    init() {
        updateLists()
        self.selectedList = lists.first
    }

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
            self.lists.append(list)
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    // delete a list
    public func deleteList(listName: String) {
        DispatchQueue.global().async {
            let request: NSFetchRequest<ListStore> = ListStore.fetchRequest()
            request.predicate = NSPredicate(format: "name == %@", listName)
            do {
                guard let listEntity = try self.context.fetch(request).first else { return }
                self.context.delete(listEntity)
                DispatchQueue.main.async {
                    self.lists.removeAll(where: { $0.name == listName })
                }
                try self.context.save()
            } catch {}
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
    public func updateLists() {
        let request: NSFetchRequest<ListStore> = ListStore.fetchRequest()
        do {
            let listStores = try self.context.fetch(request)
            self.lists = listStores.map({ getListFromStore(listStore: $0) })
        } catch {
            print("error")
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
            return nil
        }
    }
    
    // MARK: Private helper methods
    
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
