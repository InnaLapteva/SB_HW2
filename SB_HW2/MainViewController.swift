//
//  MainViewController.swift
//  SB_HW2
//
//  Created by Инна Лаптева on 14.02.2020.
//  Copyright © 2020 Inna. All rights reserved.
//

import UIKit


class MainViewController: UIViewController, ColorViewControllerDelegate {

    @IBOutlet weak var mainColorView: UIView!
    
    func updateBackgroundColor(color: UIColor) {
        mainColorView.backgroundColor = color
    }
 
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      let colorVC = segue.destination as! ColorViewController
        colorVC.ColorOfMainView = mainColorView.backgroundColor ?? UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1)
        colorVC.delegate = self
    }

}
