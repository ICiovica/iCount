//
//  ViewController.swift
//  iCount
//
//  Created by Ionut Ciovica on 28/10/2021.
//

import UIKit
import CLTypingLabel

class ViewController: UIViewController {
    
    @IBOutlet var dateLabel: CLTypingLabel!
    
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
    
     let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
         formatter.dateStyle = .full
        return formatter
    }()
    
    var timer = Timer()
    var currentDate = DateFormatter()
    var date = Date()
    var timeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gradient.frame = view.bounds
        gradient.zPosition = -10
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        view.layer.addSublayer(gradient)
        
        timer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(rollDate), userInfo: nil, repeats: false)
        
        dateLabel.textColor = .clear
    }
    
   @objc func rollDate() {
       dateLabel.textColor = .white
       dateLabel.text = dueDateFormatter.string(from: date)
    }
    
    @IBAction func goToHome(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "Home", sender: sender)
    }
    
    @IBAction func goToReminder(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "Reminder", sender: sender)
    }
    
    
    @IBAction func goToBirthday(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "Birthday", sender: sender)
    }
    
    
    @IBAction func goToCalculator(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "Calculator", sender: sender)
    }
    
    
    @IBAction func goToSplit(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "Split", sender: sender)
    }
    
    
    @IBAction func goToConverter(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "Converter", sender: sender)
    }
    
    @IBAction func goToSpendings(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "Spendings", sender: sender)
    }
    
    
    @IBAction func goToSavings(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "Savings", sender: sender)
    }
    
    
    @IBAction func goToInvest(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "Invest", sender: sender)
    }
    
    
    @IBAction func goToGoals(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "Goals", sender: sender)
    }
    
    @IBAction func goToBadges(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "Badges", sender: sender)
    }
    
    @IBAction func goToSettings(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "Settings", sender: sender)
    }
}




