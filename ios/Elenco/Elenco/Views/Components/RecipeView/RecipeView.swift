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
                RecipeHeaderView()
                Rectangle()
            }
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct RecipeHeaderView: View {
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Image(uiImage: #imageLiteral(resourceName: "test"))
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.85)
                    .cornerRadius(20)
                    .overlay(
                        VStack {
                            HStack {
                                MenuIcon()
                                Spacer()
                            }
                            .padding(.top, 40)
                            .padding(.leading)
                            
                            Text("Tomato Pasta")
                                .font(.custom("HelveticaNeue-Bold", size: 35))
                                .foregroundColor(Color.white)
                                .padding(.top, 25)
                            
                            Rectangle()
                                .foregroundColor(Color.white)
                                .frame(width: geometry.size.width * 0.2, height: 1)
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("8 Ingredients")
                                        .font(.custom("HelveticaNeue-Regular", size: 20))
                                        .foregroundColor(Color.white)
        //                                .padding(.bottom, 4)
                                    
                                    Text("Estimated time 20min")
                                        .font(.custom("HelveticaNeue-Regular", size: 20))
                                        .foregroundColor(Color.white)
                                }
                                Spacer()
                            }
                            .padding(.leading).padding(.top)
                            
                            HStack {
                                RecipeButton(title: "Edit", color: Color("Teal"), width: geometry.size.width * 0.25) {
                                    print("Hello")
                                }
                                
                                RecipeButton(title: "Delete", color: Color(#colorLiteral(red: 0.9647058824, green: 0.5058823529, blue: 0.137254902, alpha: 1)), width: geometry.size.width * 0.25) {
                                    print("Hello")
                                }
                                Spacer()
                            }
                            .padding(.top, 30).padding(.leading)
                            
                        }
                    )
                    .edgesIgnoringSafeArea(.all)
            }
        }
        
    }
}

struct RecipeButton: View {
    var title: String
    var color: Color
    var width: CGFloat
    var action: ()->()
    
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            Text(self.title)
                .padding(.vertical, 8)
                .frame(width: width)
                .background(self.color).opacity(0.8)
                .foregroundColor(Color.white)
                .font(.custom("HelveticaNeue-Medium", size: 20))
            .cornerRadius(6)
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}
