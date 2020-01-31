//
//  ViewController.swift
//  SB_HW2
//
//  Created by Manager on 31/01/2020.
//  Copyright © 2020 Inna. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
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
    
    var currentRed: Float = 0.4
    var currentBlue: Float = 0.8
    var currentGreen: Float = 0.2
    
    
    override func viewDidLoad() {
        
        showSlider(slider: redSlider, min: 0, max: 1, value: currentRed, color: .red)
        showSlider(slider: greenSlider, min: 0, max: 1, value: currentGreen, color: .green)
        showSlider(slider: blueSlider, min: 0, max: 1, value: currentBlue, color: .blue)
        
        redLabel.text = String(currentRed)
        greenLabel.text = String(currentGreen)
        blueLabel.text = String(currentBlue)
        
        colorView.layer.cornerRadius = 20
        updateViewColor(view: colorView)
        
        super.viewDidLoad()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
    }
 
    
    @IBAction func redSliderChanged() {
        currentRed = redSlider.value
        sliderWasChanged(slider: redSlider, slidersLabel: redLabel, slidersColor: currentRed)
    }
    
    @IBAction func greenSliderChanged() {
        currentGreen = greenSlider.value
        sliderWasChanged(slider: greenSlider, slidersLabel: greenLabel, slidersColor: currentGreen)
    }
    
    @IBAction func blueSliderChanged() {
        currentBlue = blueSlider.value
        sliderWasChanged(slider: blueSlider, slidersLabel: greenLabel, slidersColor: currentBlue)
    }
    
   
    //MARK: UITextFieldDelegate
    //скрываем клавиатуру при нажатии кнопки
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           return true
       }
    //скрываем клавиатуру при тапу на экран
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
  
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
               
               if let currentValue = Float(text) {
                   
                   switch textField.tag {
                   case 0:
                    redSlider.value = currentValue
                    currentRed = currentValue
                    redLabel.text = String(currentValue)
                   case 1:
                    greenSlider.value = currentValue
                    currentGreen = currentValue
                    greenLabel.text = String(currentValue)
                   case 2:
                    blueSlider.value = currentValue
                    currentBlue = currentValue
                    blueLabel.text = String(currentValue)
                   default: break
                }
                
               } else {
                    self.showAlert(with: "Wrong format", and: "Please enter in 0.00")
                }
                
                 updateViewColor(view: colorView)
    }
    //MARK: function
    
    func showSlider(slider: UISlider, min: Float, max: Float, value: Float, color: UIColor) {
        slider.minimumValue = min
        slider.maximumValue = max
        slider.value = value
        slider.minimumTrackTintColor = color
    }
    
    func updateViewColor(view: UIView){
        view.backgroundColor = UIColor(displayP3Red: CGFloat(currentRed), green: CGFloat(currentGreen), blue: CGFloat(currentBlue), alpha: 1)
    }
    
    func sliderWasChanged(slider: UISlider, slidersLabel: UILabel, slidersColor: Float) {
        slidersLabel.text = String(format: "%02.2f", slidersColor)
        updateViewColor(view: colorView)
    }
    
    func showAlert(with title: String, and message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
        
    }
    
}

