//
//  EssentialsTutorialView.swift
//  Elenco
//
//  Created by James Kenyon on 02/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct EssentialsTutorialView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 10)
                .shadow(color: self.colorScheme == .dark ? Color.black : Color("Light-Gray"), radius: 5)
                .foregroundColor(Color("Background"))
                .frame(maxWidth: 500, maxHeight: 700)
                .overlay(
                    VStack(alignment: .center) {
                        Text("Essentials List")
                            .font(.system(size: 30, weight: .bold, design: .default))
                            .foregroundColor(self.colorScheme == .dark ? Color.white : Color("Lead"))
                            .padding(.top, 35)
                        
                        Rectangle()
                            .foregroundColor(self.colorScheme == .dark ? Color.white : Color("Lead"))
                            .frame(width: geometry.size.width * 0.2, height: 1)
                
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack() {
                                Text("Your Essentials list is empty at the moment.")
                                    .padding()
                                    .font(.custom("HelveticaNeue-Bold", size: 22))
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                
                                Text("Add ingredients to your essentials list that you are likely to add to multiple lists.")
                                    .padding()
                                    .font(.custom("HelveticaNeue-Regular", size: 22))
                                    .frame(maxWidth: .infinity)
                                
                                Text("By using the actions bar at the top of any list, you can add all of the items at once.")
                                    .padding()
                                    .font(.custom("HelveticaNeue-Regular", size: 22))
                                    .frame(maxWidth: .infinity)
                            }
                            .foregroundColor(Color("BodyText"))
                            .padding(.horizontal, UIDevice.deviceIsIPad() ? 30 : 5)
                        }
                        .background(Color.clear)
                        
                    }
                , alignment: .top)
        }
    }
    
}

struct EssentialsTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        EssentialsTutorialView()
    }
}
