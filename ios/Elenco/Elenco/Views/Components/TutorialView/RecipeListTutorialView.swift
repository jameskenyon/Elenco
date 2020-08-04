//
//  RecipeListTutorialView.swift
//  Elenco
//
//  Created by James Bernhardt on 04/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct RecipeListTutorialView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 10)
                .shadow(color: self.colorScheme == .dark ? Color.black : Color("Light-Gray"), radius: 5)
                .foregroundColor(Color("Background"))
                .frame(maxWidth: 500, maxHeight: 700)
                .overlay(
                    ScrollView(.vertical) {
                        VStack(alignment: .center) {
                            Text("Welcome to recipes")
                                .font(.system(size: 30, weight: .bold, design: .default))
                                .foregroundColor(self.colorScheme == .dark ? Color.white : Color("Lead"))
                                .padding(.top)
                            
                            Rectangle()
                                .foregroundColor(self.colorScheme == .dark ? Color.white : Color("Lead"))
                                .frame(width: geometry.size.width * 0.2, height: 1)
                            
                            Text("You currently have no saved recipes.")
                                .padding().padding(.top, UIDevice.deviceIsIPad() ? 20 : 10)
                                
                            Text("All the recipes you save throughout the Elenco app can be found here. You can view the recipe methods, create a new recipe or add the recipe’s ingredients to one of your lists.")
                            .padding().padding(.top, UIDevice.deviceIsIPad() ? 20 : 10)

                            Text("To get started creating your own recipe, tap on the ➕ button below.")
                            .padding().padding(.top, UIDevice.deviceIsIPad() ? 20 : 10)

                            Text("To add a recipes ingredients to your list, either tap on a recipe when you have populated this table, or go to the action section on any list. ")
                            .padding().padding(.top, UIDevice.deviceIsIPad() ? 20 : 10)

                            Text("We hope you enjoy using the recipes feature in Elenco as much as we do 🎉")
                                .padding().padding(.top, UIDevice.deviceIsIPad() ? 20 : 10)
                            
                        .clipped()
                        }
                        .font(.custom("HelveticaNeue-Regular", size: 22))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                    }

                , alignment: .top)
        }
    }
    
}

struct RecipeListTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListTutorialView()
    }
}
