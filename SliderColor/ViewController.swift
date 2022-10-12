//
//  ViewController.swift
//  SliderColor
//
//  Created by Aleksandr on 11.10.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setColor(_ color: UIColor)
}

class ViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.color = view.backgroundColor
        settingsVC.delegate = self
    }
}

// Mark: - SettingsViewControllerDelegate
extension ViewController: SettingsViewControllerDelegate {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}



