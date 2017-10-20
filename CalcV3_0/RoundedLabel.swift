//
//  RoundedLabel.swift
//  CalcV3_0
//
//  Created by adminaccount on 10/11/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import UIKit

class RoundedLabel: UILabel {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
    }
    
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    func updateCornerRadius() {
        layer.masksToBounds = true 
        layer.cornerRadius = rounded ? frame.size.height / 8 : 0
    }
    

}
