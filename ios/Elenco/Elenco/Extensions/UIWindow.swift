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
    
    static var isDisplayingAlert = false
    
    // MARK: Private Interface
    
    /// Display an alert controller on the current window root view
    private func display(alertController: UIAlertController) {
        alertController.view.tintColor = UIColor(named: "Teal")
        if !UIWindow.isDisplayingAlert {
            self.rootViewController?.present(alertController, animated: true, completion: nil)
            UIWindow.isDisplayingAlert = true
        }
    }
    
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
            let okAction = UIAlertAction(title: okTitle, style: .default) { (action) in
                if let okHandler = okHandler {
                    okHandler(action)
                }
                UIWindow.isDisplayingAlert = false
            }
            alertController.addAction(okAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alertController.removeFromParent()
            UIWindow.isDisplayingAlert = false
        }
        alertController.addAction(cancelAction)
        display(alertController: alertController)
    }
    
    func displayChoiceAlert(title: String = "Alert", message: String? = nil, actionOneTitle: String?,
                            actionTwoTitle: String?, actionOne: ((UIAlertAction)->(Void))?,
                            actionTwo: ((UIAlertAction)->(Void))?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let actionOneTitle = actionOneTitle {
            let actionOne = UIAlertAction(title: actionOneTitle, style: .default) { (action) in
                if let actionOne = actionOne {
                    actionOne(action)
                }
                UIWindow.isDisplayingAlert = false
            }
            alertController.addAction(actionOne)
        }
        if let actionTwoTitle = actionTwoTitle {
            let actionTwo = UIAlertAction(title: actionTwoTitle, style: .default) { (action) in
                if let actionTwo = actionTwo {
                    actionTwo(action)
                }
                UIWindow.isDisplayingAlert = false
            }
            alertController.addAction(actionTwo)
        }
        display(alertController: alertController)
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
            UIWindow.isDisplayingAlert = false
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alertController.removeFromParent()
            UIWindow.isDisplayingAlert = false
        }
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        display(alertController: alertController)
    }
    
}
