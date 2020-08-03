//
//  RecipeIngredientListView.swift
//  Elenco
//
//  Created by James Bernhardt on 01/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct RecipeIngredientListView<SectionConent>: View where SectionConent: Identifiable {
    
    var sections: [RecipeListViewSection<SectionConent>]
    var addAction: (()->())?
    var saveAction: (()->())?
    
    init(sections: [RecipeListViewSection<SectionConent>]) {
        self.sections = sections
        configureTableViewAppearance()
    }
    
    init(sections: [RecipeListViewSection<SectionConent>], addAction: (()->())?, saveAction: (()->())?) {
        self.sections = sections
        self.saveAction = saveAction
        self.addAction  = addAction
        configureTableViewAppearance()
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
                                AddIngredientCell(ingredient: content as! Ingredient)
                            }
                            
                            if content as? RecipeMethod != nil {
                                AddRecipeCell(recipeMethod: content as! RecipeMethod)
                            }       
                        }
                    }
                }
                if addAction != nil && saveAction != nil {
                    HStack(alignment: .center) {
                        Text("Add")
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .font(.custom("HelveticaNeue-Medium", size: 22))
                            .foregroundColor(Color("Orange"))
                            .background(Color("Orange").opacity(0.1))
                            .onTapGesture {
                                self.addAction!()
                        }
                        
                        Text("Save")
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .font(.custom("HelveticaNeue-Medium", size: 22))
                            .foregroundColor(Color("Orange"))
                            .background(Color("Orange").opacity(0.1))
                            .onTapGesture {
                                self.saveAction!()
                        }
                    }
                }
                
            }
            .listStyle(GroupedListStyle())
        }
    }
    
    private func configureTableViewAppearance() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
    }
}