//
//  ListMenuTutorialView.swift
//  Elenco
//
//  Created by James Bernhardt on 17/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct ListMenuTutorialView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(alignment: .center, spacing: 0) {
                    
                    Text("Tap menu button to acess your changes")
                        .padding().padding(.horizontal, 30)
                        .font(.custom("HelveticaNeue-Regular", size: 22))
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Image(uiImage: self.colorScheme == .dark ? #imageLiteral(resourceName: "menuButtonIndicatorDark") : #imageLiteral(resourceName: "menuButtonIndicatorLight"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.3)
                    
                    MenuHeaderView(title: "My Lists", width: geometry.size.width * 0.8)
                        .padding(.bottom, 10)
                    
                    Image(uiImage: self.colorScheme == .dark ? #imageLiteral(resourceName: "menuTutorialDark") : #imageLiteral(resourceName: "menuTutorialLight"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.6, height: geometry.size.width * 0.25)
                    
                    
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
