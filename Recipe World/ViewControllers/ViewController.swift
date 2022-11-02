//
//  ViewController.swift
//  Recipe World
//
//  Created by M W on 02/11/2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    ////Outlets
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var timeToCookLabel: UILabel!
    @IBOutlet weak var timeToCookTextField: UITextField!
    @IBOutlet weak var ratingTitleLabel: UILabel!
    @IBOutlet weak var ratingStepper: UIStepper!
    @IBOutlet weak var userRatingLabel: UILabel!
    @IBOutlet weak var instructionsTextView: UITextView!
    ////Properties
    var recipies : [Recipe]  = []
    var timeToCookText = String()
    var ingredientsText = String()
    var instructonsText = String()
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timeToCookTextField.delegate = self
        ingredientsTextView.delegate = self
        instructionsTextView.delegate = self
    }
    
    
    @IBAction func saveRecipe(_ sender: Any) {
        
        /*
        let newRecipe = Recipe(name: <#T##String#>, ingredients: <#T##String#>, timeToCook: timeToCookText, rating: <#T##String#>, instructions: <#T##String#>, photo: <#T##UIImage#>, portionSize: <#T##Int#>, nutritionalInformation: <#T##String#>, cuisine: <#T##Cuisine#>, date: <#T##Date#>)
        */
        
    }
    
    
    
    @IBAction func stepperDidChange(_ sender: Any) {
        
        
    }
    
    ////Textfield Delegate Methods
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        timeToCookText = textField.text ?? ""
        
        
    }
    
    //// Textview Delegate Methods
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        switch textView {
        case ingredientsTextView:
            ingredientsText = textView.text ?? ""
        case instructionsTextView:
            instructonsText = textView.text ?? ""
        default:
            print("default.")
        }
        
        
    }
    
    

     // Name
    // Ingredients
    // time to cook
    // Rating
    // Instructions / steps
    // Photo
    
    //TODO:
    
    // Portion size
    // nutriton and allergy info
    // cuisine
    // date when you plan to eat it.
    
    

}

