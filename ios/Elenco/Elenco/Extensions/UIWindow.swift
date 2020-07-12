//
//  UIWindow.swift
//  Elenco
//
//  Created by James Kenyon on 30/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    
    func displayAlert(title: String = "Alert", message: String? = nil, okTitle: String?,
                      okHandler: ((UIAlertAction)->(Void))?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let okTitle = okTitle {
            let okAction = UIAlertAction(title: okTitle, style: .default, handler: okHandler)
            alertController.addAction(okAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alertController.removeFromParent()
        }
        alertController.addAction(cancelAction)
        alertController.view.tintColor = UIColor(named: "Teal")
        self.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func displayAlertWithTextField(title: String, message: String = "", placeholder: String,
                                   saveAction: @escaping (String?)->()) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = placeholder
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { (action) in
            if let textField = alertController.textFields?[0] {
                saveAction(textField.text)
            } else {
                saveAction(nil)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alertController.removeFromParent()
        }
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        alertController.view.tintColor = UIColor(named: "Teal")
        self.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
}
