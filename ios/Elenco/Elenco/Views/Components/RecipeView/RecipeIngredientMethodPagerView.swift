//
//  RecipeIngredientMethodPagerView.swift
//  Elenco
//
//  Created by James Bernhardt on 01/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct RecipieIngredientMethodPagerView: View {
    @State var currentIndex = 0
    
    var body: some View {
        GeometryReader {geometry in
            VStack {
                HStack {
                    Button(action: {
                        self.currentIndex = 0
                    }) {
                        Text("Ingredients")
                            .scaleEffect(self.currentIndex == 0 ? 1 : 0.5)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.currentIndex = 1
                    }) {
                        Text("Method")
                            .scaleEffect(self.currentIndex == 1 ? 1 : 0.5)
                    }
                }
                .foregroundColor(Color("Tungsten"))
                .font(.custom("HelveticaNeue-Bold", size: 30))
                .animation(.easeInOut(duration: 0.2))
                .padding(.horizontal, self.pagerButtonHorizontalPaddig)
                
                HStack {
                    Rectangle()
                        .foregroundColor(Color("Teal"))
                        .frame(width: self.underlineWidth(for: geometry.size), height: 2)
                        .offset(x: self.underlineOffsetX(for: geometry.size), y: 0)
                        .animation(.spring())
                    Spacer()
                }
                
                ElencoPagerView(pageCount: 2, currentIndex: self.$currentIndex, showsPageIndicator: false) {
                    Text("hello")
                    Text("Bye")
                }
            }
        }
    }
    
    // MARK: - View Constants
    func underlineWidth(for size: CGSize) -> CGFloat {
        if currentIndex == 0 {
            return 150
        }
        return 100
    }
    
    func underlineOffsetX(for size: CGSize) -> CGFloat {
        if currentIndex == 0 {
            return pagerButtonHorizontalPaddig
        }
        return size.width - underlineWidth(for: size) - pagerButtonHorizontalPaddig
    }
    
    var pagerButtonHorizontalPaddig: CGFloat {
        return 30
    }
}
