//
//  ListMenuTutorialView.swift
//  Elenco
//
//  Created by James Bernhardt on 17/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct ListMenuTutorialView: View {
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Text("Edit Your Lists")
                
                Rectangle()
                    .frame(width: geometry.size.width, height: 1)
                
                Text("Tap menu button to acess your changes")
                
                Image(uiImage: #imageLiteral(resourceName: "menuButtonIndicator"))
                
                MenuHeaderView(title: "My Lists", width: geometry.size.width)
                
                Image(uiImage: #imageLiteral(resourceName: "menuTutorialIcon"))
                
                Text("Christmas")
                    
                Text("Edit a list or add a new one in my lists view ")
            }
        }
        
    }
}

struct ListMenuTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        ListMenuTutorialView()
    }
}
