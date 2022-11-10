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
    var selectedCuisine = String()
    var ingredientsText = String()
    var instructionsText = String()
    var nutritionText = String()
    var recipeName = String()
    var timeToCookText = String()
    var image = UIImage()
    
    
    
    @IBOutlet var recipeImage: UIImageView!
    @IBOutlet var recipeNameLabel: UILabel!
    @IBOutlet var ingredientsLabel: UILabel!
    @IBOutlet var ingredientsTextView: UITextView!
    @IBOutlet var timeToCookLabel: UILabel!
    @IBOutlet var timeToCookTextField: UITextField!
    ////ratings
    @IBOutlet var ratingTitleLabel: UILabel!
    @IBOutlet var ratingStepper: UIStepper!
    @IBOutlet var userRatingLabel: UILabel!

    @IBOutlet var cuisineLabel: UILabel!

    @IBOutlet var instructionsTextView: UITextView!

    /// Portion Size
    @IBOutlet var selectedPortionSize: UILabel!
    @IBOutlet var portionSizeLabel: UILabel!
    @IBOutlet var portionStepper: UIStepper!

    ////Nutitritional Information
    @IBOutlet var NutirtionalInfoLabel: UILabel!
    @IBOutlet var nutritionalInformationTextView: UITextView!

    @IBOutlet var datePicker: UIDatePicker!
    
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
