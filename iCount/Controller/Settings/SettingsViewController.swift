//
//  SettingsViewController.swift
//  iCount
//
//  Created by Ionut Ciovica on 28/10/2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var img: UIImageView!
    
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
        
        gradient.frame = view.bounds
        gradient.zPosition = -10
        gradient.startPoint = CGPoint(x: 0, y: 1)
        
        gradient.endPoint = CGPoint(x: 0, y: 0)
        view.layer.addSublayer(gradient)
        
        let circlePath = UIBezierPath(arcCenter: view.center, radius: (img.frame.height / 2) - 30, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        
        baseShape.path = circlePath.cgPath
        baseShape.lineWidth = 30
        baseShape.strokeColor = UIColor.white.cgColor
        baseShape.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(baseShape)
        
        let redPath = UIBezierPath(arcCenter: view.center, radius: (img.frame.height / 2) - 30, startAngle: 3 * .pi / 2, endAngle: .pi / 6, clockwise: true)
        
        redShape.path = redPath.cgPath
        redShape.lineWidth = 30
        redShape.strokeColor = UIColor.systemRed.cgColor
        redShape.fillColor = UIColor.clear.cgColor
        redShape.strokeEnd = 0
        view.layer.addSublayer(redShape)
        
        let yellowPath = UIBezierPath(arcCenter: view.center, radius: (img.frame.height / 2) - 30, startAngle: .pi / 6, endAngle: 5 * .pi / 6, clockwise: true)
        
        yellowShape.path = yellowPath.cgPath
        yellowShape.lineWidth = 30
        yellowShape.strokeColor = UIColor.systemYellow.cgColor
        yellowShape.fillColor = UIColor.clear.cgColor
        yellowShape.strokeEnd = 0
        view.layer.addSublayer(yellowShape)
        
        let bluePath = UIBezierPath(arcCenter: view.center, radius: (img.frame.height / 2) - 30, startAngle: 5 * .pi / 6, endAngle: 3 * .pi / 2, clockwise: true)
        
        blueShape.path = bluePath.cgPath
        blueShape.lineWidth = 30
        blueShape.strokeColor = UIColor.systemBlue.cgColor
        blueShape.fillColor = UIColor.clear.cgColor
        blueShape.strokeEnd = 0
        view.layer.addSublayer(blueShape)
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.animateRed), userInfo: nil, repeats: true)
            self.timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.animateYellow), userInfo: nil, repeats: true)
            self.timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.animateBlue), userInfo: nil, repeats: true)
        }
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
}

