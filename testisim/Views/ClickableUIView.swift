//
//  ClickableUIView.swift
//  testisim
//
//  Created by Ahmet Can on 20.08.2018.
//  Copyright © 2018 Testisim. All rights reserved.
//

import UIKit

class ClickableUIView: UIView {
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 0.5
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1
    }
}
