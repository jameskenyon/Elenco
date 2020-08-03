
//
//  RecipeListCell.swift
//  Elenco
//
//  Created by James Bernhardt on 02/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct RecipeListCell: View {
    
    var recipe: Recipe
    
    var body: some View {
        ZStack(alignment: .leading) {
           RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.white)
            .shadow(color: Color("Light-Gray"), radius: 5, x: 0, y: 0)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(recipe.name)
                        .foregroundColor(Color("Tungsten"))
                        .font(.custom("HelveticaNeue-Bold", size: 25))
                    
                    Text(recipe.estimatedTime)
                        .foregroundColor(Color("Dark-Gray"))
                        .font(.custom("HelveticaNeue-Medium", size: 15))
                }
                .padding()
                
                Spacer()
                
                ZStack(alignment: .bottomTrailing) {
                    if recipe.image != nil {
                        Image(uiImage: recipe.image!)
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: imageSize, height: imageSize)
                            .cornerRadius(imageCornerRadius)
                    } else {
                        RoundedRectangle(cornerRadius: imageCornerRadius)
                            .frame(width: imageSize, height: imageSize)
                            .foregroundColor(Color("Light-Gray"))
                    }
                    
                    
                    Button(action: {
                        print("hello")
                    }) {
                        ZStack(alignment: .center) {
                            Circle()
                                .foregroundColor(Color("Orange"))
                                .frame(width: 25, height: 25)
                            Text("+")
                                .font(.custom("HelveticaNeue-Bold", size: 20))
                                .foregroundColor(Color.white)
                                .padding(.bottom, 5)
                        }
                        .padding(.leading, 15)
                    }
                    
                    
                }.padding()
                
                
                    
            }
            
        }
        
    }
    
    // MARK: - View Constants
    var imageSize: CGFloat {
        return 50
    }
    
    var imageCornerRadius: CGFloat {
        return imageSize / 2
    }
}
