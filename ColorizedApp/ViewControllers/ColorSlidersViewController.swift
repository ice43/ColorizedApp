//
//  ColorSlidersViewController.swift
//  ColorizedApp
//
//  Created by Serge Bowski on 11/21/23.
//

import UIKit

final class ColorSlidersViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet private weak var redLabel: UILabel!
    @IBOutlet private weak var greenLabel: UILabel!
    @IBOutlet private weak var blueLabel: UILabel!
    
    @IBOutlet private weak var redSlider: UISlider!
    @IBOutlet private weak var greenSlider: UISlider!
    @IBOutlet private weak var blueSlider: UISlider!
    
    weak var delegate: ColorSlidersViewControllerDelegate?
    
    var color: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColor()
        
        colorView.backgroundColor = color
        
        
    }
    
    
    @IBAction func sliderAction(_ sender: UISlider) {
        setColor()
        
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
        default:
            blueLabel.text = string(from: blueSlider)
        }
    }
    
    @IBAction func doneButtonPressed() {
        delegate?.setColorMainView(from: colorView)
        dismiss(animated: true)
    }
    
    
     private func setColor() {
        
        colorView.backgroundColor = UIColor(
            red: redSlider.value.cgFloat(),
            green: greenSlider.value.cgFloat(),
            blue: blueSlider.value.cgFloat(),
            alpha: 1
        )
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}


extension Float {
    func cgFloat() -> CGFloat {
        CGFloat(self)
    }
}
