//
//  RecipeHeaderView.swift
//  Elenco
//
//  Created by James Bernhardt on 01/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct RecipeHeaderView: View {
    
    var image: UIImage?
    var geometry: GeometryProxy
    
    var body: some View {
            ZStack(alignment: .top) {
                if self.image != nil {
                    Image(uiImage: self.image!)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: geometry.size.width, height: headerViewHeight)
                        .cornerRadius(headerViewCornerRadius)
                        .overlay(
                            self.headerBody(for: geometry.size)
                        )
                    
                } else {
                    RoundedRectangle(cornerRadius: headerViewCornerRadius)
                        .frame(width: geometry.size.width, height: headerViewHeight)
                        .foregroundColor(Color("Light-Gray"))
                        .overlay(
                            self.headerBody(for: geometry.size)
                        )
                }
            }
    }
    
    func headerBody(for size: CGSize) -> some View {
        VStack {
            HStack {
                MenuIcon()
                Spacer()
            }
            .padding(.top, menuIconTop)
            .padding(.leading)
            
            Text("Tomato Pasta")
                .font(.custom("HelveticaNeue-Bold", size: 35))
            
            Rectangle()
                .frame(width: underLineWidth(for: size), height: 1)
            
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
                RecipeButton(title: "Edit", color: Color("Teal"), width: buttonWidth(for: size)) {
                    print("Hello")
                }
                
                RecipeButton(title: "Delete", color: Color(#colorLiteral(red: 0.9647058824, green: 0.5058823529, blue: 0.137254902, alpha: 1)), width: buttonWidth(for: size)) {
                    print("Hello")
                }
                Spacer()
            }
            .padding(.top, buttonTop)
            .padding(.leading)
        }
        .foregroundColor(Color.white)
    }
    
    // MARK: - View Constants
    
    private var headerViewHeight: CGFloat {
        return 350
    }
    
    private var headerViewCornerRadius: CGFloat {
        return 20
    }
    
    private var menuIconTop: CGFloat {
        return geometry.safeAreaInsets.top
    }
    
    private func underLineWidth(for size: CGSize) -> CGFloat {
        return size.width * 0.2
    }
    
    private func buttonWidth(for size: CGSize) -> CGFloat {
        return size.width * 0.25
    }
    
    private var buttonTop: CGFloat {
        return 25
    }
}
