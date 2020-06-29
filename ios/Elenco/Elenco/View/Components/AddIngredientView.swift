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
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(Font.custom("HelveticaNeue-Medium", size: 22))
                    .padding(15).padding(.leading)
                    .padding(.top, viewModel.ingredients.count == 0 ? 0:10)
                    .accentColor(Color("Teal"))
                ForEach(viewModel.ingredients.indices, id: \.self) { index in
                    IngredientSearchCell(ingredient: self.viewModel.ingredients[index], index: index)
                        .padding(.top).padding(.bottom)
                        .background(index == 0 ? Color("Opaque-Teal"):Color.white)
                }
            }
            .background(Color.white)
            .cornerRadius(10)
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
                loadIngredientsFor(query: query.count >= 3 ? query : "")
            }
        }
        
        init() {
            self.ingredients = []
        }
        
        // ⚠️ Change this to minimise the calls to the api
        // ⚠️ Fix the bug that stops users from searching with spaces
        private func loadIngredientsFor(query: String) {
            IngredientAPIService.getPossibleIngredientsFor(query: query) { (ingredients) in
                DispatchQueue.main.async {
                    withAnimation { () -> () in
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
                .padding(.trailing).padding(.leading, 30)
                .font(.custom("HelveticaNeue-Regular", size: 18))
                .foregroundColor(index == 0 ?
                    Color("Dark-Gray") : Color("Light-Gray"))
            Text(ingredient.name)
                .font(.custom("HelveticaNeue-Regular", size: 18))
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
