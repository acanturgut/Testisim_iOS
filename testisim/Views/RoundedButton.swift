//
//  RoundedButton.swift
//  testisim
//
//  Created by Ahmet Can on 1.08.2018.
//  Copyright © 2018 Testisim. All rights reserved.
//

import UIKit

@IBDesignable class RoundedButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var topColor: UIColor = UIColor.white
    @IBInspectable var bottomColor: UIColor = UIColor.white
    
    @IBInspectable var didBackGroundGradient: Bool = false {
        didSet {
            
            if (didBackGroundGradient) {
                
                let gradientLayer = CAGradientLayer()
                
                gradientLayer.frame = self.bounds
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.colors = [self.topColor.cgColor, self.bottomColor.cgColor]
                
                self.layer.insertSublayer(gradientLayer, at: 0)
                
            }
        }
    }
}




