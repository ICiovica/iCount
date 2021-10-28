//
//  Extensions.swift
//  iCount
//
//  Created by Ionut Ciovica on 28/10/2021.
//

import UIKit

@IBDesignable extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
              layer.cornerRadius = newValue
              // If masksToBounds is true, subviews will be
              // clipped to the rounded corners.
              layer.masksToBounds = (newValue > 0)
        }
    }
}

extension UIColor {
    static var colorHunt = UIColor(red: 178/255, green: 64/255, blue: 128/255, alpha: 1)
}


