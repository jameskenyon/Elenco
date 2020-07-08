//
//  HostingView.swift
//  Elenco
//
//  Created by James Kenyon on 29/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

/*
 
 The DarkHostingController is a type of UIHostingController that has a light
 status bar style. All of the main views in the project will be a type of this
 view in order for them to have a light background.
 
 */

class DarkHostingController<ContentView> : UIHostingController<ContentView> where ContentView : View {
    override dynamic open var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
