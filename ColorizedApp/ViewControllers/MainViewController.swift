//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Serge Bowski on 12/7/23.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func setColorMainView(from view: UIView)
}



final class MainViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorSlidersVC = segue.destination as? SettingsViewController else {
            return
        }
        
        colorSlidersVC.delegate = self
        
        colorSlidersVC.color = view.backgroundColor
        
    }

}

// MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setColorMainView(from colorView: UIView) {
        view.backgroundColor = colorView.backgroundColor
    }
    
    
}


