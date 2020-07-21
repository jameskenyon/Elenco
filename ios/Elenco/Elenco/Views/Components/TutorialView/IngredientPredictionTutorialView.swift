//
//  IngredientPredictionTutorialView.swift
//  Elenco
//
//  Created by James Bernhardt on 20/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct IngredientPredictionTutorialView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(alignment: .center, spacing: 0) {
                    
                    Text("When you search for an ingredient, Elenco will predict what you’re looking for.")
                        .padding().padding(.bottom, UIDevice.deviceIsIPad() ? 20 : 10)
                        .font(.custom("HelveticaNeue-Regular", size: 22))
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Image(uiImage: self.colorScheme == .dark ? #imageLiteral(resourceName: "predictionTutorialDark") : #imageLiteral(resourceName: "predictionTutorialLight"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.6)
                    
                    Text("If no ingredients are predicted, you can still add the ingredient to your list.")
                        .padding().padding(.top, UIDevice.deviceIsIPad() ? 20 : 10)
                        .font(.custom("HelveticaNeue-Regular", size: 22))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(.horizontal, UIDevice.deviceIsIPad() ? 30 : 5)
        }
    }
}

struct IngredientPredictionTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientPredictionTutorialView()
    }
}
