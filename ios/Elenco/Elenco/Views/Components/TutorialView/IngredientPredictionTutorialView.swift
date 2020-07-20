//
//  IngredientPredictionTutorialView.swift
//  Elenco
//
//  Created by James Bernhardt on 20/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct IngredientPredictionTutorialView: View {
    
    var body: some View {
        ScrollView(.vertical) {
            GeometryReader { geometry in
                VStack(alignment: .center, spacing: 0) {
                    
                    Text("When you search for an ingredient, Elenco will predict what you’re looking for.")
                        .padding().padding(.horizontal, 30).padding(.bottom, 10)
                        .font(.custom("HelveticaNeue-Regular", size: 22))
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Image(uiImage: #imageLiteral(resourceName: "predictionTutorialIcon"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.6)
                    
                    Text("If no ingredients are predicted, you can still add it to your list.")
                        .padding().padding(.horizontal, 30).padding(.top, 20)
                        .font(.custom("HelveticaNeue-Regular", size: 22))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}

struct IngredientPredictionTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientPredictionTutorialView()
    }
}
