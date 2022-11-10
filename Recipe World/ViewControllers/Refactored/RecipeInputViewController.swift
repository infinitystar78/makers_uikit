//
//  ViewController.swift
//  Recipe World
//
//  Created by M W on 02/11/2022.
//

import UIKit

class RecipeInputViewController: UIViewController {
    ////Outlets

    var model = RecipeInputModel()
    @IBOutlet var recipeInputView: RecipeInputView!

    // TODO:

    // Portion size
    // nutriton and allergy info
    // cuisine
    // date when you plan to eat it.

    override func viewDidLoad() {
        super.viewDidLoad()
        recipeInputView.didSetupViews()
        actions()
        // Do any additional setup after loading the view.
    }

    func actions() {
        recipeInputView.editName = { [unowned self] in
            let alert = UIAlertController(title: "Recipe Name", message: "Enter a text", preferredStyle: .alert)
            alert.addTextField { textField in
                textField.text = "Please enter recipe"
            }
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] _ in
                let textField = alert?.textFields![0]
                self.recipeInputView.recipeNameLabel.text = textField?.text
                self.model.recipeName = self.recipeInputView.recipeNameLabel.text ?? ""
                
            }))
            present(alert, animated: true, completion: nil)
        }
        
        recipeInputView.ratingStepperChangedAction = { [unowned self] in
            self.model.userRating = recipeInputView.userRatingLabel.text ?? "0"
        }
        
        recipeInputView.portionStepperChangedAction = { [unowned self] in
            self.model.portionSize = Int(recipeInputView.userRatingLabel.text ?? "1") ?? 1
        }
        
        
        recipeInputView.instructionsTextViewInputAction = { [unowned self] textfield  in
            /*or access the parameter passed in the closure   don't user both , one or the other or rewrite closure to pass string */
            self.model.instructionsText = textfield.text
            // can access the object on RecipeInputView
        }
        
        recipeInputView.ingredientsTextViewInputAction = { [unowned self]  in
            self.model.ingredientsText = self.recipeInputView.ingredientsTextView.text ?? ""
        }
        
        
        recipeInputView.cuisneAction = { [unowned self] cuisine in
            self.model.selectedCuisine = cuisine
            
        }
    }
    
    
    
    
    @IBAction func saveRecipe(_ sender: Any) {
        model.selectedDate = recipeInputView.datePicker.date
        model.saveNewRecipe()
        model.image = recipeInputView.recipeImage.image ?? UIImage()

        let refreshAlert = UIAlertController(title: "Save", message: "Recipe will be saved to your recipe book.", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_: UIAlertAction!) in
            //// save logic
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_: UIAlertAction!) in
            //// cancel logic

        }))

        present(refreshAlert, animated: true, completion: nil)
    }
}
