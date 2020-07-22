//
//  UIWindow.swift
//  Elenco
//
//  Created by James Kenyon on 30/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation
import UIKit

/**
 Extension to the UIWindow class.
 
 - Author: James Kenyon
 */

public extension UIWindow {
    
    // MARK: Public Interface
    
    /**
     Displays an alert on the target window using the prebuilt UIAlertController.
             
     - Parameters:
        - title: The title message, defaults to Alert.
        - message: The main body of the message, optional.
        - okTitle: A title that will be displayed on the ok button - if nil then only cancel button shows.
        - okHandler: A closure that is called if the user selects the ok button. (must set okTitle for this).
     */
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
    
    /**
     Displays an alert on the target window using prebuilt UIAlertController. Contains a textfiled so that
     the user can enter data into the alert.
     
     - Parameters:
        - title: The title message, defaults to Alert.
        - message: The main body of the message, optional.
        - placeholder: Placeholder that will be displayed on the alert view.
        - saveAction: Closure that will be called if data is added to the text field and submitted.
     
     # Using the save action closure
            displayAlertWithTextField(... , saveAction: (str) in {
                // do something with textfield text
            })
     */
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
