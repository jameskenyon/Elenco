//
//  SceneDelegate.swift
//  Elenco
//
//  Created by James Kenyon on 27/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
//        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//        print(paths[0])
        
        // configure the ingredients
        IngredientAPIService.configureIngredientCache()
        // add 'All' list if required
        let allList = self.getAllList()
        updateIngredientListsIfRequired()
        updateListsIfRequired()
        
        // Get the managed object context from the shared persistent container.
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)

            let listModel = ListHolderDataModel(initialList: allList, window: window)
            
            let contentView = ListHolderView()
                .environment(\.managedObjectContext, context)
                .environmentObject(listModel)
                .environmentObject(ElencoListDataModel.shared)
            
            window.rootViewController = DarkHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    // Create the all list that will hold all the ingredients
    // if one doesn't already exist.
    private func getAllList() -> ElencoList {
        if let allList = ElencoListDataModel.shared.getLists().first {
            return allList
        } else {
            let list = ElencoList(name: ElencoDefaults.mainListName)
            ElencoListDataModel.shared.createList(list: list) { (error) in
                print("Error saving all list.")
            }
            return list
        }
    }
    
    // update the ingredients in the list so that if they have
    // a parent list type of null, they will be assigned to the 'All' list.
    private func updateIngredientListsIfRequired() {
        IngredientDataModel.shared.updateIngredientListIfRequired()
    }
    
    private func updateListsIfRequired() {
        ElencoListDataModel.shared.updateListsIfRequired()
    }

}

