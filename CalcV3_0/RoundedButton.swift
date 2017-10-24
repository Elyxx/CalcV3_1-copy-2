//
//  RoundedButton.swift
//  CalcV3_0
//
//  Created by adminaccount on 10/11/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import UIKit

//extension UIButton
class RoundedButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
    }
    
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
            setBorderWidth()
        }
    }
    func fade(){
        print("button")
        let fade = CASpringAnimation(keyPath: "transform.scale")
        fade.duration = 0.3
        fade.fromValue = 1.0
        fade.toValue = 0.99
        //fade.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        fade.autoreverses = true
        fade.repeatCount = 1
        fade.initialVelocity = 0.5
        fade.damping = 0.95
        layer.add(fade, forKey: nil)
    }
    func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 8 : 0
    }
    
    func setBorderWidth(){
        let glowColor = UIColor(red: 250.0/255.0, green: 251.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        let red = UIColor(red: 229.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        //UIColor.greenColor().CGColor
        layer.borderColor = red.cgColor
        layer.masksToBounds = true
        layer.borderWidth = 1.5
        
        titleLabel?.layer.shadowColor = glowColor.cgColor
        titleLabel?.layer.shadowRadius = 8.0
        titleLabel?.layer.shadowOpacity = 0.9
        titleLabel?.layer.shadowOffset = CGSize.zero
        titleLabel?.layer.masksToBounds = false
    }

}
