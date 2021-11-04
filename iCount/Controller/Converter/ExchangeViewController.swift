//
//  ExchangeViewController.swift
//  iCount
//
//  Created by Ionut Ciovica on 01/11/2021.
//

import UIKit
import CLTypingLabel

class ExchangeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate  {
    
    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var coinLabel: CLTypingLabel!
    @IBOutlet var currencyPicker: UIPickerView!

    @IBOutlet var coinView: UIStackView!
    
    @IBOutlet var chooseCurrency: UIView!
    
    @IBOutlet var chooseText: UITextField!
    
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
    
    var coinManager = ExchangeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradient.frame = view.bounds
        gradient.zPosition = -10
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        view.layer.addSublayer(gradient)
        
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        coinLabel.adjustsFontSizeToFitWidth = true
        
        coinView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        coinManager.currencyArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        chooseCurrency.isHidden = true
        chooseText.isHidden = true
        
        let selectedCurrency = coinManager.currencyArray[row]
        let position = coinManager.currencyArray.firstIndex(of: selectedCurrency)
        currencyLabel.text = selectedCurrency
        coinManager.getCoinPrice(for: selectedCurrency, position: position)
        
        coinView.isHidden = false
    }
    @IBAction func howToBuyEuros(_ sender: UIButton) {
        if let url = URL(string: "https://www.moneysavingexpert.com/travel/how-to-buy-euros/") {
            UIApplication.shared.open(url)
        }
    }
}

extension ExchangeViewController: ExchangeManagerDelegate {
    
    func getLastPrice(_ coinManager: ExchangeManager, coin: Double) {
        DispatchQueue.main.async {
            self.coinLabel.text = String(format: "%.2f", coin)
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
    
}
