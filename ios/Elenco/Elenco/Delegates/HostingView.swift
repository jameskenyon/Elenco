//
//  HostingView.swift
//  Elenco
//
//  Created by James Kenyon on 29/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

class DarkHostingController<ContentView> : UIHostingController<ContentView> where ContentView : View {
    override dynamic open var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
