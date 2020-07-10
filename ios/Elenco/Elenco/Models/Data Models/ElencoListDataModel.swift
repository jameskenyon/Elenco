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

    // get a list store object for when the user needs to save
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

    // ⚠️ get list object by using an id
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
    
}
