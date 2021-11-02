//
//  SplitViewController.swift
//  iCount
//
//  Created by Ionut Ciovica on 28/10/2021.
//

import UIKit

class SplitViewController: UIViewController {
    
    @IBOutlet var billTextField: UITextField!
    @IBOutlet var zeroPctButton: UIButton!
    @IBOutlet var tenPctButton: UIButton!
    @IBOutlet var twuentyPctButton: UIButton!
    @IBOutlet var splitNumberLabel: UILabel!
    @IBOutlet var calculateButton: UIButton!
    
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
    
    var tipSelected = 0.1
    var tipAmount: Double?
    var total: String?
    var numberOfPeople = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradient.frame = view.bounds
        gradient.zPosition = -10
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        view.layer.addSublayer(gradient)
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func didTapView(){
      self.view.endEditing(true)
    }
    
    @IBAction func pctButtonTapped(_ sender: UIButton) {
        if sender == zeroPctButton {
            zeroPctButton.isSelected = true
            tenPctButton.isSelected = false
            twuentyPctButton.isSelected = false
            tipSelected = 0
        } else if sender == tenPctButton {
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = true
            twuentyPctButton.isSelected = false
            tipSelected = 0.1
        } else if sender == twuentyPctButton {
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
            twuentyPctButton.isSelected = true
            tipSelected = 0.2
        }
    }
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        
        if billTextField.text == "" {
            let ac = UIAlertController(title: "Please enter your bill", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            guard let billText = billTextField.text else { return }
            guard let value = Double(billText) else { return }
             
             tipAmount = (value + value * tipSelected) / Double(numberOfPeople)
             
             total = String(format: "%.2f", tipAmount ?? 0.0)
        }
        

    }
    
    @IBAction func stepperTapped(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsViewController" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = String(format: "%.2f", tipAmount ?? 0.0)
            destinationVC.settings = "Split between \(numberOfPeople) people, with \(Int(tipSelected * 100))% tip."
        }
    }
}
