//
//  RecipeInputModel.swift
//  Recipe World
//
//  Created by M W on 08/11/2022.
//

import Foundation
import UIKit

class RecipeInputModel {
    
    var ingredientsTitle = "Ingredients"
    var timeToCookTitle = "Time to cook"
    var ratingTitle = "Rating"
    var instructionsTitle = "Instructions"
    var portionSizeTitle = "Portion Size"
    var nutritionalInformationTitle = "Nutritional Information"
    var dateTitle = "Date"
    var timeToCookTextFieldPrompt = "Time to cook"
    
    var recipies: [Recipe] = []   // recipe data
    var userRating = String()
    var portionSize = Int()
    var selectedDate = Date()
    var selectedCuisine: Cuisine = .british
    var ingredientsText = String()
    var instructionsText = String()
    var nutritionText = String()
    var recipeName = String()
    var timeToCookText = String()
    var image = UIImage()
    
    func saveNewRecipe(){
        let newRecipe = Recipe(name: recipeName, ingredients: ingredientsText, timeToCook: timeToCookText, rating: userRating, instructions: instructionsText, photo: image, portionSize: portionSize, nutritionalInformation: nutritionText, cuisine: selectedCuisine, date: selectedDate)
        
        
        
    }
    
    func callNetworkService(){}
    
    func saveRecipe() -> Bool {
      //TODO: write out save function
     return false
        
    }
    
    func doublePortionSize(portionSize: Int) -> Int{
        return portionSize * 2
    }
}
