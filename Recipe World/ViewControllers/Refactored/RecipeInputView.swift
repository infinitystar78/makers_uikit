//
//  RecipeInputView.swift
//  Recipe World
//
//  Created by M W on 09/11/2022.
//

import UIKit

protocol RecipeInputViewInput: AnyObject {
}

class RecipeInputView: UIView {
    @IBOutlet var editNameButton: UIButton!

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

    // communication functions

    var editName: (() -> Void)?
    var ratingStepperChangedAction: (() -> Void)?
    var portionStepperChangedAction: (() -> Void)?
    var instructionsTextViewInputAction: ((UITextView) -> Void)?
    var ingredientsTextViewInputAction: (() -> Void)?
    var cuisneAction: ((String) -> Void)?   // no parameter names in closures
    var timeToCookAction: (() -> Void)?

    // UI elements
    var toolBar = UIToolbar()
    var picker = UIPickerView()

    func didSetupViews() {
        setupLabels()
        setupSteppers()
        setupTextViews()
        setupTextFields()
    }

    private func setupLabels() {
        cuisineLabel.isUserInteractionEnabled = true
        cuisineLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectCusine)))
    }

    private func setupTextFields() {
        timeToCookTextField.delegate = self
        timeToCookTextField.keyboardType = .numberPad
        timeToCookTextField.addDoneButtonOnKeyboard()
    }

    private func setupTextViews() {
        ingredientsTextView.delegate = self
        instructionsTextView.delegate = self
        ingredientsTextView.addDoneButton(title: "Done", target: self, selector: #selector(dismiss(sender:)))
        instructionsTextView.addDoneButton(title: "Done", target: self, selector: #selector(dismiss(sender:)))
        nutritionalInformationTextView.addDoneButton(title: "Done", target: self, selector: #selector(dismiss(sender:)))
    }

    private func setupSteppers() {
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
}

extension RecipeInputView {
    @objc func dismiss(sender: Any) {
        endEditing(true)
    }

    @objc func ratingStepperChanged() {
        userRatingLabel.text = String(ratingStepper.value)
    }

    @objc func portionStepperChanged() {
        selectedPortionSize.text = String(portionStepper.value)
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
        addSubview(picker)

        toolBar = UIToolbar(frame: CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .black
        toolBar.isTranslucent = true
        toolBar.items = [UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        addSubview(toolBar)
    }

    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
}

extension RecipeInputView {
    @IBAction func editName(_ sender: Any) {
        editName!()
    }
}

extension RecipeInputView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let timeToCookAction = timeToCookAction {
            timeToCookAction()
        }
        // unwrapped
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

extension RecipeInputView: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        switch textView {
        case ingredientsTextView:
            instructionsTextViewInputAction!(textView)
        
        case instructionsTextView:
            instructionsTextViewInputAction!(textView)
        default:
            print("default.")
        }
    }
}

extension RecipeInputView: UIPickerViewDelegate, UIPickerViewDataSource {
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
        cuisneAction!(Cuisine.allCases[row].rawValue.capitalized)
      
    }
}
