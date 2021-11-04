//
//  InvestViewController.swift
//  iCount
//
//  Created by Ionut Ciovica on 28/10/2021.
//

import UIKit
import CLTypingLabel

class InvestViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate  {
    
    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var bitcoinLabel: CLTypingLabel!
    @IBOutlet var currencyPicker: UIPickerView!
    @IBOutlet var bitcoinView: UIStackView!
    @IBOutlet var chooseCurrency: UIView!
    @IBOutlet var chooseText: UITextField!
    @IBOutlet var buyView: UIStackView!
    
    var coinManager = CoinManager()
    
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
    
    var currentDate = DateFormatter()
    
    
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
        
        bitcoinLabel.adjustsFontSizeToFitWidth = true
        
        bitcoinView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    @IBAction func buyBTC(_ sender: UIButton) {
        if let url = URL(string: "https://bitcoin.org/en/buy") {
            UIApplication.shared.open(url)
        }
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
        currencyLabel.text = selectedCurrency
        coinManager.getCoinPrice(for: selectedCurrency)
        bitcoinView.isHidden = false
    }
}

extension InvestViewController: CoinManagerDelegate {
    
    func getLastPrice(_ coinManager: CoinManager, coin: Double) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = String(format: "%.2f", coin)
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
