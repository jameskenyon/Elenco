//
//  AddIngredientView.swift
//  Elenco
//
//  Created by James Kenyon on 27/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct AddIngredientView: View {

    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                TextField("Add Ingredient...", text: $viewModel.query)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                ForEach(viewModel.ingredients.indices, id: \.self) { index in
                    IngredientSearchCell(ingredient: self.viewModel.ingredients[index], index: index)
                        .padding(.top)
                        .padding(.bottom)
                        .background(index == 0 ? Color("Opaque-Teal"):Color.white)
                }
            }
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color("Dark-Gray"), radius: 4)
        }
        .padding()
    }
}

extension AddIngredientView {
    class ViewModel: ObservableObject {
        
        @Published private(set) var ingredients: Ingredients = []
        
        @Published var query:String = "" {
            didSet {
                print(query)
                // update ingredients when new query is set
                loadIngredientsFor(query: self.query)
            }
        }
        
        init() {
            self.ingredients = []
            
            self.ingredients = [
                Ingredient(name: "Carrot", id: 1, aisle: "Veg"),
                Ingredient(name: "Carrot Juice", id: 2, aisle: "Drink"),
                Ingredient(name: "Carrot Cake", id: 3, aisle: "Sweet"),
                Ingredient(name: "Peas and Carrots", id: 4, aisle: "Veg")
            ]
            /*
             
             
             */
        }
        
        // ⚠️ Change this to minimise the calls to the api
        private func loadIngredientsFor(query: String) {
            if query.count >= 3 {
                IngredientAPIService.getPossibleIngredientsFor(query: query, numResults: 5) { (ingredients) in
                    DispatchQueue.main.async {
                        self.ingredients = ingredients
                    }
                }
            }
        }
    }
}

struct IngredientSearchCell:View {
    
    // Properties
    var ingredient: Ingredient
    var index: Int
    
    var body: some View {
        HStack {
            Text("\(index + 1)")
                .padding(.trailing)
                .padding(.leading, 30)
                .foregroundColor(index == 0 ?
                    Color("Dark-Gray") : Color("Light-Gray"))
            Text(ingredient.name)
            Spacer()
        }
    }
}

#if DEBUG
struct AddIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        AddIngredientView()
    }
}
#endif
