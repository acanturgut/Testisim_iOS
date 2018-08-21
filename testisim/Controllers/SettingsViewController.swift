//
//  SettingsViewController.swift
//  testisim
//
//  Created by Ahmet Can on 20.08.2018.
//  Copyright © 2018 Testisim. All rights reserved.
//

import UIKit
import UserNotifications

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    @IBOutlet weak var reminderCountTextView: UILabel!
    
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        decreaseButton.isEnabled = notificationSwitch.isOn
        increaseButton.isEnabled = notificationSwitch.isOn
        
        if (UserDefaults.standard.bool(forKey: UserDefaultsKeys.NOTIFICATION_STATUS)) {
            
            notificationSwitch.isOn = true
            
        } else {
            
            notificationSwitch.isOn = false
            switchAction(isSwitchOn: false)
            
        }
        
        let notificationCount = UserDefaults.standard.integer(forKey: UserDefaultsKeys.NOTIFICATION_COUNT)
        
        reminderCountTextView.text = "\(notificationCount)"
        
        if (notificationCount == 1) {
            decreaseButton.isEnabled = false
        } else if (notificationCount == 3) {
            increaseButton.isEnabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onNotificationsSwitchChanged(_ sender: Any) {
        UserDefaults.standard.set(self.notificationSwitch.isOn, forKey: UserDefaultsKeys.NOTIFICATION_STATUS)
        switchAction(isSwitchOn: self.notificationSwitch.isOn)
    }
    
    @IBAction func onDecreaseButtonClicked(_ sender: Any) {
        
        if let textToValue = reminderCountTextView!.text {
            
            var count = Int(textToValue)!
            
            if (count > 1) {
                
                count = count - 1
                reminderCountTextView.text =  "\(count)"
            }
            
            UserDefaults.standard.set(count, forKey: UserDefaultsKeys.NOTIFICATION_COUNT)
            
            if (count == 1) {
                
                decreaseButton.isEnabled = false
                
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                createNotification(timeInterval: 864000 * 3)
                
            } else if (count == 2) {
                
                increaseButton.isEnabled = true
                decreaseButton.isEnabled = true
                
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                createNotification(timeInterval: 864000 * 2)
                
            } else if (count == 3) {
                
                decreaseButton.isEnabled = true
                
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                createNotification(timeInterval: 864000)
            }
        }
    }
    
    @IBAction func onIncreaseButtonClicked(_ sender: Any) {
        
        if let textToValue = reminderCountTextView!.text {
            
            var count = Int(textToValue)!
            
            if (count < 3) {
                
                count = count + 1

                reminderCountTextView.text =  "\(count)"
            }
            
             UserDefaults.standard.set(count, forKey: UserDefaultsKeys.NOTIFICATION_COUNT)
            
            if (count == 1) {
                
                increaseButton.isEnabled = true
                
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                createNotification(timeInterval: 864000 * 3)
                
            } else if (count == 2) {
                
                increaseButton.isEnabled = true
                decreaseButton.isEnabled = true
                
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                createNotification(timeInterval: 864000 * 2)
                
            } else if (count == 3) {
                
                increaseButton.isEnabled = false
                
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                createNotification(timeInterval: 864000)
            }
        }
    }
    
    private func switchAction(isSwitchOn: Bool) {
        
        decreaseButton.isEnabled = isSwitchOn
        increaseButton.isEnabled = isSwitchOn
        
        reminderCountTextView.alpha = isSwitchOn ? 1.0 : 0.3
        reminderCountTextView.text = isSwitchOn ? "1" : "0"
        
        if (isSwitchOn) {
            
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            
            decreaseButton.isEnabled = false
            
            createNotification(timeInterval: 864000 * 3)
            
        } else {
            
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }
    
    private func createNotification(timeInterval: Double) {
        
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Test Zamanı", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Ayarladığın şekilde testis kontrolünü yapmayı unutma", arguments: nil)
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "notify-testisim"
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: timeInterval, repeats: true)
        let request = UNNotificationRequest.init(identifier: "notify-testisim", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
}
