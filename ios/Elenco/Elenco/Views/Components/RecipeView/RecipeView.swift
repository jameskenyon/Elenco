//
//  RecipeView.swift
//  Elenco
//
//  Created by James Bernhardt on 01/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct RecipeView: View {
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                RecipeHeaderView(image: nil)
                Rectangle()
            }
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct RecipeHeaderView: View {
    
    var image: UIImage?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                if self.image != nil {
                    Image(uiImage: self.image!)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.85)
                        .cornerRadius(20)
                        .overlay(
                            self.headerBody(for: geometry.size)
                        )
                    
                } else {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.85)
                        .foregroundColor(Color("Light-Gray"))
                        .overlay(
                            self.headerBody(for: geometry.size)
                        )
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    func headerBody(for size: CGSize) -> some View {
        VStack {
            HStack {
                MenuIcon()
                Spacer()
            }
            .padding(.top, 40)
            .padding(.leading)
            
            Text("Tomato Pasta")
                .font(.custom("HelveticaNeue-Bold", size: 35))
                .padding(.top, 25)
                .padding(.leading, nil)
            
            Rectangle()
                .frame(width: size.width * 0.2, height: 1)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("8 Ingredients")
                    Text("Estimated time 20min")
                }
                Spacer()
            }
            .font(.custom("HelveticaNeue-Regular", size: 20))
            .padding(.leading)
            .padding(.top)
            
            HStack {
                RecipeButton(title: "Edit", color: Color("Teal"), width: size.width * 0.25) {
                    print("Hello")
                }
                
                RecipeButton(title: "Delete", color: Color(#colorLiteral(red: 0.9647058824, green: 0.5058823529, blue: 0.137254902, alpha: 1)), width: size.width * 0.25) {
                    print("Hello")
                }
                Spacer()
            }
            .padding(.top, 30)
            .padding(.leading)
        }
        .foregroundColor(Color.white)
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}
