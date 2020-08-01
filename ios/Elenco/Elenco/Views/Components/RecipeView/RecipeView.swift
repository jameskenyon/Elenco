//
//  RecipeView.swift
//  Elenco
//
//  Created by James Bernhardt on 01/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct RecipeView: View {
    
    @State var currentIndex = 0
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.currentIndex = 0
                }) {
                    Text("Ingredients")
                }
                
                Spacer()
                
                Button(action: {
                    self.currentIndex = 1
                }) {
                    Text("Recipe")
                }
            }
            .foregroundColor(Color("Tungsten"))
            .font(.custom("HelveticaNeue-Bold", size: 35))
            .padding()
            
            ElencoPagerView(pageCount: 2, currentIndex: $currentIndex, showsPageIndicator: false) {
                Text("hello")
                Text("Bye")
            }
        }
        
        
    }
}


struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}
