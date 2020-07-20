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
            ScrollView(.vertical) {
                VStack(alignment: .center, spacing: 0) {
                    
                    Text("Tap menu button to acess your changes")
                        .padding().padding(.horizontal, 30)
                        .font(.custom("HelveticaNeue-Regular", size: 22))
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Image(uiImage: #imageLiteral(resourceName: "menuButtonIndicator"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.3)
                    
                    MenuHeaderView(title: "My Lists", width: geometry.size.width * 0.8)
                        .padding(.bottom, 10)
                    
                    Image(uiImage: #imageLiteral(resourceName: "menuTutorialIcon"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.3)
                    
                    
                    Text("Edit a list or add a new one in my lists view ")
                        .padding().padding(.horizontal, 30).padding(.top)
                        .font(.custom("HelveticaNeue-Regular", size: 22))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }  
}

struct ListMenuTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        ListMenuTutorialView()
    }
}
