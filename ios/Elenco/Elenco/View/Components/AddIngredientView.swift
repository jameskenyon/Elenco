//
//  AddIngredientView.swift
//  Elenco
//
//  Created by James Kenyon on 27/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct AddIngredientView: View {

    // global observed model
    @EnvironmentObject var myListModel: MyListData
    // local observed model
    @ObservedObject var searchViewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                TextField("Add Ingredient...", text: $searchViewModel.query, onCommit: {
                    if self.searchViewModel.query.trimmingCharacters(in: [" "]) != "" {
                        let nameAndQuantity = Ingredient.getIngredientNameAndQuantity(searchText:
                            self.searchViewModel.query)
                        let name  = nameAndQuantity.0
                        let quantity = nameAndQuantity.1
                        let aisle = IngredientAPIService.getAisleForIngredient(ingredientName: name)
                        self.myListModel.addIngredient(ingredient:
                            Ingredient(name: self.searchViewModel.query, id: 0, aisle: aisle, quantity: quantity)
                        )
                    }
                })
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(Font.custom("HelveticaNeue-Medium", size: 22))
                    .padding(15).padding(.leading)
                    .padding(.top, searchViewModel.searchIngredients.count == 0 ? 0:10)
                    .accentColor(Color("Teal"))
                ForEach(searchViewModel.searchIngredients.indices, id: \.self) { index in
                    IngredientSearchCell(ingredient: self.searchViewModel.searchIngredients[index],
                                         index: index, query: self.searchViewModel.query)
                        .padding(.top).padding(.bottom)
                        .background(index == 0 ? Color("Opaque-Teal"):Color.white)
                        .onTapGesture {
                            self.searchViewModel.query = self.searchViewModel.searchIngredients[index].name
                        }
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
    
    class SearchViewModel: ObservableObject {
        
        @Published private(set) var searchIngredients: Ingredients = []
        
        @Published var query:String = "" {
            didSet {
                loadIngredientsFor(query: query)
            }
        }
        
        private func loadIngredientsFor(query: String) {
            // user must type at least 3 letters before beginning auto-complete
            if query.count >= 2 {
                let results = IngredientAPIService.getPossibleIngredientsFor(query: query)
                DispatchQueue.main.async {
                    withAnimation { () -> () in
                        self.searchIngredients = results
                    }
                }
            } else {
                withAnimation { () -> () in
                    self.searchIngredients = []
                }
            }
        }
    }
}

struct IngredientSearchCell: View {
    
    // Properties
    var ingredient: Ingredient
    var index: Int
    var query: String
    
    var body: some View {
        HStack {
            Text("\(index + 1)")
                .padding(.trailing).padding(.leading, 30)
                .font(.custom("HelveticaNeue-Regular", size: 18))
                .foregroundColor(index == 0 ?
                    Color("Dark-Gray") : Color("Light-Gray"))
            SemiBoldLabel(text: ingredient.name.lowercased(), query: query.lowercased(),
                          font: .custom("HelveticaNeue-Regular", size: 20))
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
