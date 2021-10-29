//
//  ResultsViewController.swift
//  iCount
//
//  Created by Ionut Ciovica on 29/10/2021.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var settingsLabel: UILabel!
    
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
    
    var result = "0.0"
    var settings = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        gradient.frame = view.bounds
        gradient.zPosition = -10
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        view.layer.addSublayer(gradient)
        
        totalLabel.text = result
        settingsLabel.text = settings
    }
    
    @IBAction func recalculateTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
