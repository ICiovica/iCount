//
//  BirthdayViewController.swift
//  iCount
//
//  Created by Ionut Ciovica on 28/10/2021.
//

import UIKit

class BirthdayViewController: UIViewController {
    
    lazy var gradient: CAGradientLayer = {
         let gradient = CAGradientLayer()
         gradient.type = .axial
         gradient.colors = [
             UIColor.colorHunt.cgColor,
             UIColor.purple.cgColor,
             UIColor.cyan.cgColor
         ]
         gradient.locations = [0, 0.25, 1]
         
         return gradient
     }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradient.frame = view.bounds
        gradient.zPosition = -10
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        view.layer.addSublayer(gradient)
    }
}
