//
//  RecipeIngredientMethodPagerView.swift
//  Elenco
//
//  Created by James Bernhardt on 01/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct RecipieIngredientMethodPagerView: View {
    
    let recipes = Recipe.getRecipes()
    @State var currentIndex = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Button(action: {
                        self.currentIndex = 0
                    }) {
                        Text("Ingredients")
                            .scaleEffect(self.currentIndex == 0 ? 1 : 0.7)
                            .foregroundColor(self.currentIndex == 0 ? Color("Lead") : Color("Dark-Gray"))
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.currentIndex = 1
                    }) {
                        Text("Method")
                            .scaleEffect(self.currentIndex == 1 ? 1 : 0.7)
                        .foregroundColor(self.currentIndex == 1 ? Color("Lead") : Color("Dark-Gray"))
                    }
                }
                .font(.custom("HelveticaNeue-Bold", size: 25))
                .animation(.easeInOut(duration: 0.2))
                .padding(.horizontal, self.pagerButtonHorizontalPaddig)
                .padding(.top)
                
                HStack {
                    Rectangle()
                        .foregroundColor(Color("Teal"))
                        .frame(width: self.underlineWidth(for: geometry.size), height: 4)
                        .offset(x: self.underlineOffsetX(for: geometry.size), y: 0)
                        .animation(.spring())
                    Spacer()
                }
                
                ElencoPagerView(pageCount: 2, currentIndex: self.$currentIndex, showsPageIndicator: false) {
                    RecipeIngredientListView(sections: self.ingredientsSortedByName())
                    RecipeIngredientListView(sections: self.methodsSortedIntoSections())
                }
                .padding(.top)
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
    
    // MARK: - TODO move these
    // Return ingredients sorted into alphabetical sections
    public func ingredientsSortedByName() -> [RecipeListViewSection<Ingredient>] {
        let ingredients = recipes.first!.ingredients
        var sections = [RecipeListViewSection<Ingredient>]()
        let sectionHeaders = Set(ingredients.map({ $0.name.first?.lowercased() ?? ""}))
        
        // Filter ingredients in each section
        for header in sectionHeaders {
            let ingredientsInSection = ingredients.filter({ $0.name.first?.lowercased() ?? "" == header })
            let section = RecipeListViewSection<Ingredient>(title: String(header), content: ingredientsInSection)
            sections.append(section)
        }
        sections = sections.sorted(by: { $0.title < $1.title })
        return sections
    }
    
    // Return Methods sorted into sectinos
    public func methodsSortedIntoSections() -> [RecipeListViewSection<RecipeMethod>] {
        
        let methods = recipes.first!.method
        var sections = [RecipeListViewSection<RecipeMethod>]()
        for method in methods {
            let section = RecipeListViewSection<RecipeMethod>(title: "\(method.number)", content: [method])
            sections.append(section)
        }
        return sections
    }
}

struct RecipeIngredientMethodPagerView_Previews: PreviewProvider {
    static var previews: some View {
        RecipieIngredientMethodPagerView()
    }
}
