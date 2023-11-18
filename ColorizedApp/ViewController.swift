//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Serge Bowski on 11/18/23.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var colorView: UIView!
    
    @IBOutlet private weak var redValueShiftLabel: UILabel!
    @IBOutlet private weak var greenValueShiftLabel: UILabel!
    @IBOutlet private weak var blueValueShiftLabel: UILabel!
    
    @IBOutlet private weak var redSlider: UISlider!
    @IBOutlet private weak var greenSlider: UISlider!
    @IBOutlet private weak var blueSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeViewColor()
        
    }
    
    
    @IBAction private func redSliderAction() {
        getValue(of: redSlider, to: redValueShiftLabel)
        changeViewColor()
    }
    
    
    @IBAction private func greenSliderAction() {
        getValue(of: greenSlider, to: greenValueShiftLabel)
        changeViewColor()
    }
    
    
    @IBAction private func blueSliderAction() {
        getValue(of: blueSlider, to: blueValueShiftLabel)
        changeViewColor()
    }
    
    private func getValue(of slider: UISlider, to label: UILabel) {
        label.text = String(format: "%.2f", slider.value)
    }
    
    private func changeViewColor() {
        
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
}


