//
//  SettingsViewController.swift
//  ColorizedApp
//
//  Created by Serge Bowski on 11/21/23.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    @IBOutlet private weak var colorView: UIView!
    
    @IBOutlet private weak var redLabel: UILabel!
    @IBOutlet private weak var greenLabel: UILabel!
    @IBOutlet private weak var blueLabel: UILabel!
    
    @IBOutlet private weak var redSlider: UISlider!
    @IBOutlet private weak var greenSlider: UISlider!
    @IBOutlet private weak var blueSlider: UISlider!
    
    @IBOutlet private weak var redSliderTextField: UITextField!
    @IBOutlet private weak var greenSliderTextField: UITextField!
    @IBOutlet private weak var blueSliderTextField: UITextField!
    
    weak var delegate: SettingsViewControllerDelegate?
    
    var color: UIColor!
    
    lazy var toolBar: UIToolbar = {
        let tool: UIToolbar = .init(
            frame: CGRect(
                x: 0,
                y: 0,
                width: UIScreen.main.bounds.width,
                height: 35
            )
        )
        tool.barStyle = .default
        tool.tintColor = .systemBlue
        tool.sizeToFit()
        
        let spaceArea: UIBarButtonItem = .init(systemItem: .flexibleSpace)
        let doneButton: UIBarButtonItem = .init(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(doneBarButtonPressed)
        )
        tool.setItems([spaceArea, doneButton], animated: false)
        tool.isUserInteractionEnabled = true
        
        
        return tool
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColor()
        colorView.backgroundColor = color
        
        extractValuesForSliders()
        assignSliderValuesToLabels()
        assignSliderValuesToTextFields()

        assignTextFieldsDelegate()
        
        addAccessoryViewForInputOfTF()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IB Actions
    @IBAction func sliderAction(_ sender: UISlider) {
        setColor()
        
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
            redSliderTextField.text = string(from: redSlider)
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
            greenSliderTextField.text = string(from: greenSlider)
        default:
            blueLabel.text = string(from: blueSlider)
            blueSliderTextField.text = string(from: blueSlider)
        }
    }
    
    @IBAction func doneButtonPressed() {
        delegate?.setColorMainView(from: colorView)
        dismiss(animated: true)
    }
    
    
    // MARK: - Private Methods
    private func setColor() {
        
        colorView.backgroundColor = UIColor(
            red: redSlider.value.cgFloat(),
            green: greenSlider.value.cgFloat(),
            blue: blueSlider.value.cgFloat(),
            alpha: 1
        )
    }
    
    private func extractValuesForSliders() {
        
        redSlider.value = Float(color.redValue)
        greenSlider.value = Float(color.greenValue)
        blueSlider.value = Float(color.blueValue)
    }
    
    private func assignSliderValuesToLabels() {
        
        redLabel.text = string(from: redSlider)
        greenLabel.text = string(from: greenSlider)
        blueLabel.text = string(from: blueSlider)
    }
    
    private func assignSliderValuesToTextFields() {
        
        redSliderTextField.text = string(from: redSlider)
        greenSliderTextField.text = string(from: greenSlider)
        blueSliderTextField.text = string(from: blueSlider)
    }
    
    private func assignTextFieldsDelegate() {
        
        redSliderTextField.delegate = self
        greenSliderTextField.delegate = self
        blueSliderTextField.delegate = self
    }
    
    private func alert(withTitle title: String, andMessage message: String) {
        
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func string(from float: Float) -> String {
        String(format: "%.2f", float)
    }
    
    private func wrongData() {
        alert(withTitle: "Wrong format!", andMessage: "Please, enter correct value")
    }
    
    private func addAccessoryViewForInputOfTF() {
        redSliderTextField.inputAccessoryView = toolBar
        greenSliderTextField.inputAccessoryView = toolBar
        blueSliderTextField.inputAccessoryView = toolBar
    }
    
    @objc private func doneBarButtonPressed() {
        redSliderTextField.resignFirstResponder()
        greenSliderTextField.resignFirstResponder()
        blueSliderTextField.resignFirstResponder()
    }
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let redSliderTFFloat = Float(redSliderTextField.text!),
              let greenSliderTFFloat = Float(greenSliderTextField.text!),
              let blueSliderTFFloat = Float(blueSliderTextField.text!) else {
            wrongData()
            return
        }
        
        guard 0...1 ~= redSliderTFFloat,
              0...1 ~= greenSliderTFFloat,
              0...1 ~= blueSliderTFFloat else {
            wrongData()
            return
        }
        
        
        switch textField {
        case redSliderTextField:
            
            redSlider.setValue(redSliderTFFloat, animated: true)
            redLabel.text = string(from: redSliderTFFloat)
            setColor()
            
        case greenSliderTextField:
            
            greenSlider.setValue(greenSliderTFFloat, animated: true)
            greenLabel.text = string(from: greenSliderTFFloat)
            setColor()
            
        case blueSliderTextField:
            
            blueSlider.setValue(blueSliderTFFloat, animated: true)
            blueLabel.text = string(from: blueSliderTFFloat)
            setColor()
            
        default:
            wrongData()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}




// MARK: - Other interesting extensions
extension Float {
    func cgFloat() -> CGFloat {
        CGFloat(self)
    }
}


extension UIColor {
    var redValue: CGFloat{ return CIColor(color: self).red }
    var greenValue: CGFloat{ return CIColor(color: self).green }
    var blueValue: CGFloat{ return CIColor(color: self).blue }
    var alphaValue: CGFloat{ return CIColor(color: self).alpha }
}


