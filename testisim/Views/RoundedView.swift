//
//  RoundedView.swift
//  testisim
//
//  Created by Ahmet Can on 5.08.2018.
//  Copyright © 2018 Testisim. All rights reserved.
//

import UIKit

class RoundedView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

}
