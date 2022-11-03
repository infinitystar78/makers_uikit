//
//  ViewController.swift
//  Recipe World
//
//  Created by M W on 02/11/2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    ////Outlets
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

    ////Properties
    var recipies: [Recipe] = []
    var timeToCookText = String()
    var ingredientsText = String()
    var instructonsText = String()
    var nutritionText = String()
    var recipeName = String()

    var userRating = String()

    var portionSize = Int()
    var selectedCuisine: Cuisine = .quick

    var selectedDate = Date()

    var toolBar = UIToolbar()
    var picker = UIPickerView()

    // TODO:

    // Portion size
    // nutriton and allergy info
    // cuisine
    // date when you plan to eat it.

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timeToCookTextField.delegate = self
        timeToCookTextField.keyboardType = .numberPad
        timeToCookTextField.addDoneButtonOnKeyboard()

        cuisineLabel.isUserInteractionEnabled = true
        cuisineLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectCusine)))
        setupSteppers()
        setupTextViews()
    }

    func setupTextViews() {
        ingredientsTextView.delegate = self
        instructionsTextView.delegate = self
        ingredientsTextView.addDoneButton(title: "Done", target: self, selector: #selector(dismiss(sender:)))
        instructionsTextView.addDoneButton(title: "Done", target: self, selector: #selector(dismiss(sender:)))
        nutritionalInformationTextView.addDoneButton(title: "Done", target: self, selector: #selector(dismiss(sender:)))
    }

    func setupSteppers() {
        ////rating Steppers
        ratingStepper.maximumValue = 0
        ratingStepper.maximumValue = 5
        ratingStepper.value = 0
        userRatingLabel.text = String(ratingStepper.value)
        ratingStepper.addTarget(self, action: #selector(ratingStepperChanged), for: .valueChanged)
        ////portion Size
        portionStepper.maximumValue = 1
        portionStepper.maximumValue = 6
        portionStepper.value = 0
        selectedPortionSize.text = String(portionStepper.value)
        portionStepper.addTarget(self, action: #selector(portionStepperChanged), for: .valueChanged)
    }

    @objc func dismiss(sender: Any) {
        view.endEditing(true)
    }

    @objc func ratingStepperChanged() {
        userRatingLabel.text = String(ratingStepper.value)
        userRating = userRatingLabel.text ?? "0"
    }

    @objc func portionStepperChanged() {
        selectedPortionSize.text = String(portionStepper.value)
        portionSize = Int(userRatingLabel.text ?? "1") ?? 1
    }

    @objc func selectCusine() {
        picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        view.addSubview(picker)

        toolBar = UIToolbar(frame: CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .black
        toolBar.isTranslucent = true
        toolBar.items = [UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        view.addSubview(toolBar)
    }

    @IBAction func saveRecipe(_ sender: Any) {
        selectedDate = datePicker.date

        let newRecipe = Recipe(name: recipeName, ingredients: ingredientsText, timeToCook: timeToCookText, rating: userRating, instructions: instructonsText, photo: recipeImage.image ?? UIImage(), portionSize: portionSize, nutritionalInformation: nutritionText, cuisine: selectedCuisine, date: selectedDate)

        let refreshAlert = UIAlertController(title: "Save", message: "Recipe will be saved to your recipe book.", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_: UIAlertAction!) in
            //// save logic
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_: UIAlertAction!) in
            //// cancel logic

        }))

        present(refreshAlert, animated: true, completion: nil)
    }

    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }

    @IBAction func editName(_ sender: Any) {
        let alert = UIAlertController(title: "Recipe Name", message: "Enter a text", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = "Please enter recipe"
        }

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] _ in
            let textField = alert?.textFields![0]
            self.recipeNameLabel.text = textField?.text
            self.recipeName = self.recipeNameLabel.text ?? ""

        }))
        present(alert, animated: true, completion: nil)
    }

    @IBAction func stepperDidChange(_ sender: Any) {
    }

    ////Textfield Delegate Methods

    func textFieldDidEndEditing(_ textField: UITextField) {
        timeToCookText = textField.text ?? ""
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
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

    // Picker view delegate methods

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Cuisine.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Cuisine.allCases[row].rawValue
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cuisineLabel.text = Cuisine.allCases[row].rawValue.capitalized
        selectedCuisine = Cuisine.allCases[row]
    }

    // date picker methods
}
