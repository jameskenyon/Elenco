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
                    
                    Rectangle()
                        .overlay(
                            VStack(alignment: .leading, spacing: 0) {
                                ZStack {
                                    Capsule()
                                    .foregroundColor(Color(#colorLiteral(red: 0.368627451, green: 0.7883469462, blue: 0.6629261374, alpha: 1)))
                                    .frame(width: geometry.size.width, height: 50)
                                        .padding(.trailing, geometry.size.width * 0.2)
                                    HStack {
                                        Text("All")
                                        .font(.custom("HelveticaNeue-Regular", size: 20))
                                            .foregroundColor(Color.white)
                                        
                                        
                                        Image(uiImage: #imageLiteral(resourceName: "editList"))
                                            .resizable()
                                            .foregroundColor(Color.white)
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 25, height: 25)
                                        
                                        Image(uiImage: #imageLiteral(resourceName: "deleteList"))
                                            .resizable()
                                            .foregroundColor(Color.white)
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 25, height: 25)
                                    }
                                }
                                
                                
                                MenuViewListCell(list: ElencoList(name: "Christmas"), isEditing: false)
                            }
                            
                        )
                        .frame(width: geometry.size.width * 0.7, height: geometry.size.width / 4)
                        .foregroundColor(Color.clear)
                    .clipped()
//                    Image(uiImage: self.colorScheme == .dark ? #imageLiteral(resourceName: "menuTutorialDark") : #imageLiteral(resourceName: "menuTutorialLight"))
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: geometry.size.width * 0.6, height: geometry.size.width * 0.25)
                    
                    
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
