//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Serge Bowski on 12/7/23.
//

import UIKit

protocol ColorSlidersViewControllerDelegate: AnyObject {
    func setColorMainView(from view: UIView)
}



final class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorSlidersVC = segue.destination as? ColorSlidersViewController else {
            return
        }
        
        colorSlidersVC.delegate = self
        
        colorSlidersVC.color = view.backgroundColor
        
//        colorSlidersVC.redValue = Float(colorSlidersVC.color.ciColor.red)
//        colorSlidersVC.greenValue = Float(colorSlidersVC.color.ciColor.green)
//        colorSlidersVC.blueValue = Float(colorSlidersVC.color.ciColor.blue)
        
    }

}

// MARK: - ColorSlidersViewControllerDelegate
extension MainViewController: ColorSlidersViewControllerDelegate {
    func setColorMainView(from colorView: UIView) {
        view.backgroundColor = colorView.backgroundColor
    }
    
    
}


