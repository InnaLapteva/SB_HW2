//
//  ViewController.swift
//  SB_HW2
//
//  Created by Manager on 31/01/2020.
//  Copyright © 2020 Inna. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {
    
    //MARK: properties
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
    
    var ColorOfMainView = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1)
    
    var delegate: ColorViewControllerDelegate!
    
    //MARK:Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSliderValue()
        loadUIElements()
        colorView.layer.cornerRadius = 20
        
        updateViewColor(view: colorView)
        
        addDoneButtonOnKeyboard()

        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
    }
    
    
    //MARK: IB Actions
    @IBAction func redSliderChanged() {
        
        sliderWasChanged(slider: redSlider, slidersLabel: redLabel, slidersColor: redSlider.value, textField: redTextField)
    }
    
    @IBAction func greenSliderChanged() {
        
        sliderWasChanged(slider: greenSlider, slidersLabel: greenLabel, slidersColor: greenSlider.value, textField: greenTextField)
    }
    
    @IBAction func blueSliderChanged() {
        
        sliderWasChanged(slider: blueSlider, slidersLabel: greenLabel, slidersColor: blueSlider.value, textField: blueTextField)
    }
    
    
  //MARK: Navigation
    @IBAction func doneButtonPressed() {
        delegate.updateBackgroundColor(color: ColorOfMainView)
        dismiss(animated: true)
    }
    
}

//MARK: UITextFieldDelegate

extension ColorViewController: UITextFieldDelegate {
    //скрываем клавиатуру при нажатии кнопки
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //скрываем клавиатуру при тапе на экран
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
                redLabel.text = String(currentValue)
            case 1:
                greenSlider.value = currentValue
                greenLabel.text = String(currentValue)
            case 2:
                blueSlider.value = currentValue
                blueLabel.text = String(currentValue)
            default: break
            }
            
        } else {
            self.showAlert(with: "Wrong format", and: "Please enter in 0.00")
            textField.text = ""
        }
        
        updateViewColor(view: colorView)
    }
    
    
}

//MARK: functions

extension ColorViewController {
    
    
    func setSliderValue() {
        
        let ciColor = CIColor(color: ColorOfMainView)
        
        redSlider.value =  Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    func loadUIElements() {
        showSlider(slider: redSlider, min: 0, max: 1, value: redSlider.value, color: .red)
        showSlider(slider: greenSlider, min: 0, max: 1, value: greenSlider.value, color: .green)
        showSlider(slider: blueSlider, min: 0, max: 1, value: blueSlider.value, color: .blue)
        
        redLabel.text = String(format: "%02.2f", redSlider.value)
        greenLabel.text = String(format: "%02.2f", greenSlider.value)
        blueLabel.text = String(format: "%02.2f", blueSlider.value)
        
        redTextField.text = String(format: "%02.2f", redSlider.value)
        greenTextField.text = String(format: "%02.2f", greenSlider.value)
        blueTextField.text = String(format: "%02.2f", blueSlider.value)
    }
    
    
    
    func showSlider(slider: UISlider, min: Float, max: Float, value: Float, color: UIColor) {
        slider.minimumValue = min
        slider.maximumValue = max
        slider.value = value
        slider.minimumTrackTintColor = color
    }
    
    func updateViewColor(view: UIView){
        
        ColorOfMainView = UIColor(displayP3Red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
        view.backgroundColor = ColorOfMainView
        
    }
    
    func sliderWasChanged(slider: UISlider, slidersLabel: UILabel, slidersColor: Float, textField: UITextField) {
        slidersLabel.text = String(format: "%02.2f", slidersColor)
        textField.text = String(format: "%02.2f", slidersColor)
        updateViewColor(view: colorView)
    }
    
    func showAlert(with title: String, and message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
        
    }
    
    func addDoneButtonOnKeyboard() {
        
        let doneButtonToolBar = UIToolbar()
        doneButtonToolBar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction))
        
        var items = [UIBarButtonItem]()
        
        items.append(flexSpace)
        items.append(doneButton)
        
        doneButtonToolBar.items = items
        doneButtonToolBar.sizeToFit()
        
        self.redTextField.inputAccessoryView = doneButtonToolBar
        self.greenTextField.inputAccessoryView = doneButtonToolBar
        self.blueTextField.inputAccessoryView = doneButtonToolBar
    }
    
    @objc func doneButtonAction()
    {
        view.endEditing(true)
        self.redTextField.resignFirstResponder()
        self.greenTextField.resignFirstResponder()
        self.blueTextField.resignFirstResponder()
        
    }
    
}


