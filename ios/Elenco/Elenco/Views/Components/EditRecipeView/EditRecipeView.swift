//
//  EditRecipeView.swift
//  Elenco
//
//  Created by James Bernhardt on 02/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct EditRecipeView: View {
    
    @EnvironmentObject var recipeDataModel: RecipeHolderDataModel
    @EnvironmentObject var listHolderDataModel: ListHolderDataModel
    
    @State var recipeName: String = ""
    @State var selectedImage = UIImage()
    @State var time: String = ""
    @State var serves: String = ""
    @State var showAlert = false
    @State var isShowingImagePicker = false
    @State var alertAction: ((String?)->())?
    
    init() {
        UISwitch.appearance().onTintColor = #colorLiteral(red: 0.3696106672, green: 0.7883469462, blue: 0.6629261374, alpha: 1)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(alignment: .leading) {
                    HStack {
                        RecipeEditField(fieldName: "Name", placeholder: "Recipe Name", fieldText: self.$recipeName, size: geometry.size, keyboardType: .default)
                        
                        VStack {
                            Text("Image")
                                .font(.custom("HelveticaNeue-Regular", size: 15))
                                .foregroundColor(Color("Teal"))

                            ZStack {
                                if self.recipeDataModel.selectedRecipe.image == nil {
                                    RoundedRectangle(cornerRadius: 35)
                                    .foregroundColor(Color("Light-Gray"))
                                    .frame(width: 70, height: 70)
                                } else {
                                    Image(uiImage: self.selectedImage)
                                        .resizable()
                                        .scaledToFill()
                                        .clipped()
                                        .colorMultiply(.gray)
                                        .frame(width: 70, height: 70)
                                        .cornerRadius(35)
                                }
                                Image(uiImage: #imageLiteral(resourceName: "editList"))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                            .sheet(isPresented: self.$isShowingImagePicker) {
                                ImagePickerView(isPresented: self.$isShowingImagePicker, selectedImage: self.$selectedImage)
                            }
                            .onTapGesture {
                                self.isShowingImagePicker.toggle()
                            }
                        }
                        .padding(.top)
                    }.padding(.bottom, -10)

                    RecipeEditField(fieldName: "Time", placeholder: "Time To Make", fieldText: self.$time, size: geometry.size, keyboardType: .default)
                    
                    RecipeEditField(fieldName: "Serves", placeholder: "Number Of Servings", fieldText: self.$serves, size: geometry.size, keyboardType: .numberPad)
                    
                    ZStack {
                        IngredientMethodPagerView(addIngredientAction: {
                            self.addIngredientButtonTapped()
                        }, saveIngredientActoin: {
                            self.saveRecipe()
                        }, addMethodAction: {
                            self.addMethodStepButtonTapped()
                        }, saveMethodAction: {
                            self.saveRecipe()
                        })
                        
                        VStack {
                            Spacer()
                            
                            HStack(alignment: .center) {

                                Button(action: {
                                    self.addIngredientButtonTapped()
                                }) {
                                    Text("Add Item")
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 20)
                                        .font(.custom("HelveticaNeue-Medium", size: 22))
                                        .foregroundColor(Color("Orange"))
                                        .background(Color("Orange").opacity(0.2))
                                        .cornerRadius(6)
                                }
                                
                                Button(action: {
                                    self.saveRecipe()
                                }) {
                                    Text("Save Changes")
                                        .cornerRadius(10)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 20)
                                        .font(.custom("HelveticaNeue-Medium", size: 22))
                                        .foregroundColor(Color("Teal"))
                                        .background(Color("Teal").opacity(0.2))
                                        .cornerRadius(6)
                                }
                            }.padding(.leading)
                        }
                    }
                }
                .blur(radius: self.showAlert ? 3 : 0)
                .onAppear {
                    self.configureTextFieldContent()
                }
                
                if self.showAlert {
                    ElencoAlert(title: "Add Item", message: "", placeholder: "Add item here") { (text) in
                        self.alertAction!(text)
                        withAnimation {
                           self.showAlert = false
                        }
                    }
                    .scaleEffect(self.showAlert ? 1 : 0.4)
                    .opacity(self.showAlert ? 1 : 0.4)
                        .animation(.easeOut)
                    .transition(AnyTransition.scale.combined(with: .opacity))
                    .padding(.bottom, 200)
                }
            }
        }
    }
    
    // MARK: - View methods
    
    // Set text field content to be that of selected recipe
    private func configureTextFieldContent() {
        self.recipeName = self.recipeDataModel.selectedRecipe.name.capitalized
        self.time = self.recipeDataModel.selectedRecipe.estimatedTime
        let recipeServes = self.recipeDataModel.selectedRecipe.serves
        self.serves = recipeServes != 0 ? "\(recipeServes)" : ""
        selectedImage = recipeDataModel.selectedRecipe.image ?? UIImage()
    }
    
    // Enable user to input ingredient name and display in list
    private func addIngredientButtonTapped() {
        withAnimation {
            self.showAlert = true
        }
        alertAction = { text in
            guard let ingredientString = text   else { return }
            let ingredientInfo = Ingredient.getIngredientNameAndQuantity(searchText: ingredientString)
            
            self.recipeDataModel.addIngredient(name: ingredientInfo.0, quantity: ingredientInfo.1)
        }
    }
    
    // Enable user to add a instruction to recipe
    private func addMethodStepButtonTapped() {
        withAnimation {
            showAlert = true
        }
        alertAction = { text in
            guard let methodString = text else { return }
            self.recipeDataModel.addMethod(for: methodString)
        }
    }
    
    // Save recipe to core data and stop showing edit recipe page
    private func saveRecipe() {
        if recipeDataModel.isNewRecipe {
            recipeDataModel.saveRecipe(name: recipeName, time: time, serves: serves, image: selectedImage)
        } else {
            recipeDataModel.updateRecipe(name: recipeName, time: time, serves: serves, image: selectedImage)
        }
        recipeDataModel.hideViews()
    }
}
