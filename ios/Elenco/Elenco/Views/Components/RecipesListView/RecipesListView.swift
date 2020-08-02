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
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
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
        }
    }
}

struct RecipeListCell: View {
    
    var image: UIImage?
    
    var body: some View {
        ZStack(alignment: .leading) {
           RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.white)
            .shadow(color: Color("Light-Gray"), radius: 5, x: 0, y: 0)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Chicken Bask")
                        .foregroundColor(Color("Tungsten"))
                        .font(.custom("HelveticaNeue-Bold", size: 25))
                    
                    Text("20mins")
                        .foregroundColor(Color("Dark-Gray"))
                        .font(.custom("HelveticaNeue-Medium", size: 15))
                }
                .padding()
                
                Spacer()
                
                ZStack(alignment: .bottomTrailing) {
                    Image(uiImage: image!)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: imageSize, height: imageSize)
                        .cornerRadius(imageCornerRadius)
                    
                    Button(action: {
                        print("hello")
                    }) {
                        ZStack(alignment: .center) {
                            Circle()
                                .foregroundColor(Color("Orange"))
                                .frame(width: 25, height: 25)
                            Text("+")
                                .font(.custom("HelveticaNeue-Bold", size: 20))
                                .foregroundColor(Color.white)
                                .padding(.bottom, 5)
                        }
                        .padding(.leading, 15)
                    }
                    
                    
                }.padding()
                
                
                    
            }
            
        }
        
    }
    
    // MARK: - View Constants
    var imageSize: CGFloat {
        return 50
    }
    
    var imageCornerRadius: CGFloat {
        return imageSize / 2
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesListView()
    }
}
