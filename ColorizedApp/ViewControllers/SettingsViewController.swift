//
//  SettingsViewController.swift
//  ColorizedApp
//
//  Created by Serge Bowski on 11/21/23.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet private weak var colorView: UIView!
    
    @IBOutlet private weak var redLabel: UILabel!
    @IBOutlet private weak var greenLabel: UILabel!
    @IBOutlet private weak var blueLabel: UILabel!
    
    @IBOutlet private weak var redSlider: UISlider!
    @IBOutlet private weak var greenSlider: UISlider!
    @IBOutlet private weak var blueSlider: UISlider!
    
    @IBOutlet private weak var redTextField: UITextField!
    @IBOutlet private weak var greenTextField: UITextField!
    @IBOutlet private weak var blueTextField: UITextField!
    
    // MARK: - Public properties
    unowned var delegate: SettingsViewControllerDelegate!
    var color: UIColor!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.backgroundColor = color
        
        setValue(for: redSlider, greenSlider, blueSlider)
        setValue(for: redLabel, greenLabel, blueLabel)
        setValue(for: redTextField, greenTextField, blueTextField)
        
//        assignTextFieldsDelegate()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IB Actions
    @IBAction func sliderAction(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setValue(for: redLabel)
            setValue(for: redTextField)
        case greenSlider:
            setValue(for: greenLabel)
            setValue(for: greenSlider)
        default:
            setValue(for: blueLabel)
            setValue(for: blueSlider)
        }
        
        setColor()
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setColor(colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
}

// MARK: - Private Methods
extension SettingsViewController {
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: redSlider.value.cgFloat(),
            green: greenSlider.value.cgFloat(),
            blue: blueSlider.value.cgFloat(),
            alpha: 1
        )
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                label.text = string(from: redSlider)
            case greenLabel:
                label.text = string(from: greenSlider)
            default:
                label.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField:
                textField.text = string(from: redSlider)
            case greenTextField:
                textField.text = string(from: redSlider)
            default:
                textField.text = string(from: redSlider)
            }
        }
    }
    
    private func setValue(for colorSliders: UISlider...) {
        let ciColor = CIColor(color: color)
        colorSliders.forEach { colorSlider in
            switch colorSlider {
            case redSlider:
                colorSlider.value = Float(ciColor.red)
            case greenSlider:
                colorSlider.value = Float(ciColor.green)
            default:
                colorSlider.value = Float(ciColor.blue)
            }
        }
    }

    
//    private func assignTextFieldsDelegate() {
//        
//        redTextField.delegate = self
//        greenTextField.delegate = self
//        blueTextField.delegate = self
//    }
    
    private func showAlert(
        withTitle title: String,
        andMessage message: String,
        textField: UITextField? = nil
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = "0.50"
            textField?.becomeFirstResponder()
        }
        
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func string(from float: Float) -> String {
        String(format: "%.2f", float)
    }
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            showAlert(
                withTitle: "Wrong format!",
                andMessage: "Please, enter correct value"
            )
            return
        }
        
        guard let currentValue = Float(text), (0...1).contains(currentValue) else {
            showAlert(
                withTitle: "Wrong format!",
                andMessage: "Please, enter correct value",
                textField: textField
            )
            return
        }
        
        switch textField {
        case redTextField:
            redSlider.setValue(currentValue, animated: true)
            setValue(for: redLabel)
        case greenTextField:
            greenSlider.setValue(currentValue, animated: true)
            setValue(for: greenLabel)
        default:
            blueSlider.setValue(currentValue, animated: true)
            setValue(for: blueLabel)
        }
        
        setColor()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        textField.inputAccessoryView = keyboardToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: textField,
            action: #selector(resignFirstResponder)
        )
        
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexibleSpace, doneButton]
    }
    
}




// MARK: - Other interesting extensions
extension Float {
    func cgFloat() -> CGFloat {
        CGFloat(self)
    }
}


