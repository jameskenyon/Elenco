//
//  RecipeIngredientListView.swift
//  Elenco
//
//  Created by James Bernhardt on 01/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct RecipeListViewSection<SectionContent> where SectionContent: Identifiable {
    var title: String
    var content: [SectionContent]
}

struct RecipeIngredientListView<SectionConent>: View where SectionConent: Identifiable {
    
    var sections: [RecipeListViewSection<SectionConent>]
    
    init(sections: [RecipeListViewSection<SectionConent>]) {
        self.sections = sections
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
    }
            
    var body: some View {
        VStack {
            HStack {
                Text("NAME")
                
                Spacer()
                
                Text("QTY")
            }
            .foregroundColor(Color("Dark-Gray"))
            .font(.custom("HelveticaNeue-Regular", size: 12))
            .padding(.horizontal, 35).padding(.bottom)
            
            List {
                ForEach(sections, id: \.title) { section in
                    Section(header:
                        IngredientSectionHeader(title: section.title)
                            .padding(.top, -18)
                    ) {
                        ForEach(section.content) { content in
                            if content as? Ingredient != nil {
                                RecipeIngredientListViewCell(ingredient: content as! Ingredient)
                            }
                            
                            if content as? RecipeMethod != nil {
                                RecipeMethodListViewCell(recipeMethod: content as! RecipeMethod)
                            }       
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
        }
    }
}

struct RecipeIngredientListViewCell: View {
    var ingredient: Ingredient
    
    var body: some View {
        HStack {
            Text(ingredient.name)
                .foregroundColor(Color("Lead"))
                .font(.custom("HelveticaNeue-Regular", size: 23))
            
            Spacer()
            
            Text(ingredient.quantity ?? "")
            .foregroundColor(Color("Dark-Gray"))
            .font(.custom("HelveticaNeue-Regular", size: 15))
        }
        .padding(.horizontal)
    }
}

struct RecipeMethodListViewCell: View {
    
    var recipeMethod: RecipeMethod
    
    var body: some View {
        Text(recipeMethod.instruction)
            .foregroundColor(Color("Lead"))
            .font(.custom("HelveticaNeue-Regular", size: 23))
        .padding(.horizontal)
    }
}

struct RecipeIngredientListView_Previews: PreviewProvider {
    static var previews: some View {
        return RecipeMethodListViewCell(recipeMethod: RecipeMethod(number: 1, instruction: "Stick it in"))
    }
}
