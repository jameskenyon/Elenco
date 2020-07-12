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
    
    // delete a list
    public func deleteList(listName: String) {
        DispatchQueue.global().async {
            let request: NSFetchRequest<ListStore> = ListStore.fetchRequest()
            request.predicate = NSPredicate(format: "name == %@", listName)
            do {
                guard let listEntity = try self.context.fetch(request).first else { return }
                self.context.delete(listEntity)
                try self.context.save()
            } catch {}
        }
    }
    
    // update the name of a list
    public func updateListName(list: ElencoList, newName: String) {
        let request: NSFetchRequest<ListStore> = ListStore.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", list.name)
        do {
            guard let listEntity = try self.context.fetch(request).first else {
                return
            }
            listEntity.setValue(newName, forKey: "name")
            try self.context.save()
        } catch {} // ignore for now
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
            return nil
        }
    }
    
    // MARK: Private helper methods
    
    // get list from store
    private func getListFromStore(listStore: ListStore) -> ElencoList {
        return ElencoList(listStore: listStore)
    }
    
}
