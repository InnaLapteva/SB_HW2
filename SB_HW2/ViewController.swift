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
    
    //MARK:
    
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
    
}

