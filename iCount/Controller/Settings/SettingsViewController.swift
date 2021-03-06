//
//  SettingsViewController.swift
//  iCount
//
//  Created by Ionut Ciovica on 28/10/2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var img: UIImageView!
    
    @IBOutlet var cityLabel: UILabel!
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
    
    let baseShape = CAShapeLayer()
    let redShape = CAShapeLayer()
    let yellowShape = CAShapeLayer()
    let blueShape = CAShapeLayer()
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityLabel.adjustsFontSizeToFitWidth = true
        
        gradient.frame = view.bounds
        gradient.zPosition = -10
        gradient.startPoint = CGPoint(x: 0, y: 1)
        
        gradient.endPoint = CGPoint(x: 0, y: 0)
        view.layer.addSublayer(gradient)
        
        let radius = img.bounds.size.height / 2
        
        let circlePath = UIBezierPath(arcCenter: view.center, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        
        baseShape.path = circlePath.cgPath
        baseShape.lineWidth = 25
        baseShape.strokeColor = UIColor.white.cgColor
        baseShape.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(baseShape)
        
        let redPath = UIBezierPath(arcCenter: view.center, radius: radius, startAngle: 3 * .pi / 2, endAngle: .pi / 6, clockwise: true)
        
        redShape.path = redPath.cgPath
        redShape.lineWidth = 25
        redShape.strokeColor = UIColor.systemRed.cgColor
        redShape.fillColor = UIColor.clear.cgColor
        redShape.strokeEnd = 0
        view.layer.addSublayer(redShape)
        
        let yellowPath = UIBezierPath(arcCenter: view.center, radius: radius, startAngle: .pi / 6, endAngle: 5 * .pi / 6, clockwise: true)
        
        yellowShape.path = yellowPath.cgPath
        yellowShape.lineWidth = 25
        yellowShape.strokeColor = UIColor.systemYellow.cgColor
        yellowShape.fillColor = UIColor.clear.cgColor
        yellowShape.strokeEnd = 0
        view.layer.addSublayer(yellowShape)
        
        let bluePath = UIBezierPath(arcCenter: view.center, radius: radius, startAngle: 5 * .pi / 6, endAngle: 3 * .pi / 2, clockwise: true)
        
        blueShape.path = bluePath.cgPath
        blueShape.lineWidth = 25
        blueShape.strokeColor = UIColor.systemBlue.cgColor
        blueShape.fillColor = UIColor.clear.cgColor
        blueShape.strokeEnd = 0
        view.layer.addSublayer(blueShape)
        
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.animateRed), userInfo: nil, repeats: true)
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.animateYellow), userInfo: nil, repeats: true)
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.animateBlue), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    @objc func animateRed() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        self.redShape.add(animation, forKey: "animation")
    }
    
    @objc func animateYellow() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        self.yellowShape.add(animation, forKey: "animation")
    }
    @objc func animateBlue() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        self.blueShape.add(animation, forKey: "animation")
    }
    
    @IBAction func goToLinkedin(_ sender: UIButton) {
        if let url = URL(string: "https://www.linkedin.com/in/ionut-ciovica-335ab9149/") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func goToGitHub(_ sender: UIButton) {
        if let url = URL(string: "https://github.com/ICiovica") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func goToTwitter(_ sender: UIButton) {
        if let url = URL(string: "https://twitter.com/IonutCiovica") {
            UIApplication.shared.open(url)
        }
    }
}

