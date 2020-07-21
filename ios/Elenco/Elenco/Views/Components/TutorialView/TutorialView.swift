//
//  TutorialView.swift
//  Elenco
//
//  Created by James Bernhardt on 17/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct TutorialView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var currentPage: Int = 0
    @State var tutorialTitles = ["Edit Your Lists", "Smart Ingredient Adding", "Ingredient Prediction"]
    
    var body: some View {
        GeometryReader { geometry in
            
            
            RoundedRectangle(cornerRadius: 10)
                .shadow(color: self.colorScheme == .dark ? Color.black : Color("Light-Gray"), radius: 5)
                .foregroundColor(Color("Background"))
                
                .overlay(
                    VStack(alignment: .center) {
                        Text(self.tutorialTitles[self.currentPage])
                            .font(.system(size: 30, weight: .bold, design: .default))
                            .foregroundColor(self.colorScheme == .dark ? Color.white : Color("Lead"))
                            .padding(.top, 25)
                            .animation(.default)
                        
                        Rectangle()
                            .foregroundColor(self.colorScheme == .dark ? Color.white : Color("Lead"))
                            .frame(width: geometry.size.width * 0.2, height: 1)
                        
                        ElencoPagerView(pageCount: 3, currentIndex: self.$currentPage) {
                            AddIngredientTutorialView()
                            ListMenuTutorialView()
                            IngredientPredictionTutorialView()
                        }
                    }
                , alignment: .top)
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
