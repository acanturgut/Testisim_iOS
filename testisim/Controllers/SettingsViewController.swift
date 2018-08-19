//
//  SettingsViewController.swift
//  testisim
//
//  Created by Ahmet Can on 20.08.2018.
//  Copyright © 2018 Testisim. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    @IBOutlet weak var reminderCountTextView: UILabel!
    
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        decreaseButton.isEnabled = notificationSwitch.isOn
        increaseButton.isEnabled = notificationSwitch.isOn
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onNotificationsSwitchChanged(_ sender: Any) {
        
        decreaseButton.isEnabled = notificationSwitch.isOn
        increaseButton.isEnabled = notificationSwitch.isOn
        
        reminderCountTextView.alpha = notificationSwitch.isOn ? 1.0 : 0.3
        reminderCountTextView.text = notificationSwitch.isOn ? "1" : "0"
        
    }
    
    @IBAction func onDecreaseButtonClicked(_ sender: Any) {
        
        if let textToValue = reminderCountTextView!.text {
            
            if (Int(textToValue)! > 1) {
                
                reminderCountTextView.text =  "\(Int(textToValue)! - 1)"
                
            }
        }
    }
    
    @IBAction func onIncreaseButtonClicked(_ sender: Any) {
        
        if let textToValue = reminderCountTextView!.text {
            
            if (Int(textToValue)! < 12) {
                
                reminderCountTextView.text =  "\(Int(textToValue)! + 1)"
                
            }
        }
        
    }
    
}
