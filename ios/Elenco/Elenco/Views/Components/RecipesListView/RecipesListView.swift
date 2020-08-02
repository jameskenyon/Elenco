//
//  RecipesView.swift
//  Elenco
//
//  Created by James Bernhardt on 01/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct RecipesListView: View {
    
    @EnvironmentObject var contentViewDataModel: ContentViewDataModel
    @EnvironmentObject var recipeViewDataModel: RecipeHolderDataModel
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            if recipeViewDataModel.editRecipiesIsShown {
                Text("Edit")
            } else {
                listView()
            }
        }
    }
    
    // MARK: - Recipe List View
    public func listView() -> some View {
        ZStack(alignment: .center) {
            VStack {
                List {
                    RecipeListCell(image: #imageLiteral(resourceName: "predictionTutorialDark"))
                }
                Button(action: {
                    self.contentViewDataModel.menuIsShown = true
                }) {
                    Text("Back")
                }
            }
            ZStack {
                Button(action: {
                    self.recipeViewDataModel.editRecipiesIsShown = true
                }) {
                    Text("+")
                        .font(.custom("HelveticaNeue-Regular", size: 40))
                        .foregroundColor(Color.white)
                }.buttonStyle(OrangeCircleButtonStyle())
            }
        }
    }
}


struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesListView()
    }
}
