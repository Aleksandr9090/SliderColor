//
//  SettingsViewController.swift
//  SliderColor
//
//  Created by Aleksandr on 07.10.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var color: UIColor!
    var delegate: SettingsViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        colorView.layer.cornerRadius = 10
        
        setColor()
        setSliders()
        updateLabels()
        updateTextFields()
        colorView.backgroundColor = color
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setColor(colorView.backgroundColor ?? UIColor.red)
        view.endEditing(true)
        updateSliders()
        setColor()
        dismiss(animated: true)
    }
    
    @IBAction func rgbSlider(_ sender: UISlider) {
        setColor()
        updateLabels()
        updateTextFields()
    }
    
    private func updateLabels() {
        redLabel.text = String(format: "%.2f", redSlider.value)
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        blueLabel.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func updateTextFields() {
        redTextField.text = String(format: "%.2f", redSlider.value)
        greenTextField.text = String(format: "%.2f", greenSlider.value)
        blueTextField.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func updateSliders() {
        redSlider.value = Float(redTextField.text ?? "0") ?? 0
        greenSlider.value = Float(greenTextField.text ?? "0") ?? 0
        blueSlider.value = Float(blueTextField.text ?? "0") ?? 0
    }
    
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
    
    private func setSliders() {
        let ciColor = CIColor(color: color)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let numberValue = Float(newValue) else { return }
        
        if textField == redTextField {
            redSlider.setValue(numberValue, animated: true)
        } else if textField == greenTextField {
            greenSlider.setValue(numberValue, animated: true)
        } else {
            blueSlider.setValue(numberValue, animated: true)
        }
        setColor()
        return
    }
}


