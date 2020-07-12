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
    @EnvironmentObject var listHolderModel: ListHolderDataModel
    // local observed model for getting ingredient data
    @ObservedObject var searchViewModel = SearchViewModel()
    // hold the colour scheme for dark mode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    TextField("Add Ingredient...", text: $searchViewModel.query, onCommit: {
                        self.userDidAddReturnOnTextField()
                    })
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(Font.custom("HelveticaNeue-Medium", size: 22))
                        .padding(15).padding(.leading)
                        .padding(.top, searchViewModel.searchIngredients.count == 0 ? 0:10)
                        .accentColor(Color("Teal"))
                        .foregroundColor(Color("BodyText"))
                        .background(Color("Background"))
                    if searchViewModel.query.count != 0 {
                        Button(action: {
                            self.addIngredient()
                            UIApplication.resignResponder()
                        }) {
                            Text("+")
                                .font(.custom("HelveticaNeue-Bold", size: 34))
                                .foregroundColor(Color("Orange"))
                        }
                        .padding(.trailing, 20).padding(.bottom, 4)
                        .background(Color("Background"))
                    }
                }
                .background(Color("Background"))
                
                ForEach(searchViewModel.searchIngredients.indices, id: \.self) { index in
                    IngredientSearchCell(ingredient: self.searchViewModel.searchIngredients[index],
                                         index: index, query: self.searchViewModel.query)
                        .padding(.top).padding(.bottom)
                        .background(index == 0 ? Color("Opaque-Teal"):Color("Background"))
                        .onTapGesture {
                            self.searchViewModel.query = self.searchViewModel.searchIngredients[index].name.capitalise()
                            UIApplication.resignResponder()
                        }
                }
                .background(Color("Background"))
            }
            .background(Color("Background"))
            .cornerRadius(10)
            .shadow(color: colorScheme == .dark ? .clear : Color("Dark-Gray") , radius: 4)
        }
        .padding()
    }
    
    // Called when the user adds an ingredient by returning on the text field
    private func userDidAddReturnOnTextField() {
        let query = self.searchViewModel.query
        if query.trimmingCharacters(in: [" "]) != "" {
            if listHolderModel.userHasIngredient(name: query) {
                listHolderModel.window.displayAlert(title: "You already have this ingredient.",
                                                okTitle: "Add anyway") { (alert) -> (Void) in
                                                    self.addIngredient()
                }
            } else {
                addIngredient()
            }
        }
    }
    
    private func addIngredient() {
        let nameAndQuantity = Ingredient.getIngredientNameAndQuantity(searchText:
                   self.searchViewModel.query)
        let name  = nameAndQuantity.0
        let quantity = nameAndQuantity.1
        let aisle = IngredientAPIService.getAisleForIngredient(ingredientName: name)
        self.listHolderModel.addIngredient(ingredient:
            Ingredient(ingredientID: UUID(), name: name, aisle: aisle, quantity: quantity, parentList: self.listHolderModel.list)
        )
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
