//
//  SplashViewController.swift
//  testisim
//
//  Created by Ahmet Can on 31.07.2018.
//  Copyright © 2018 Testisim. All rights reserved.
//

import UIKit
import FirebaseAuth
import UserNotifications

class SplashViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ( UserDefaults.standard.bool(forKey: UserDefaultsKeys.IS_USER_COMPLATE_TUTORIALS)) {
            Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(sequeToMainMenu), userInfo: nil, repeats: false)
        } else {
            
            Auth.auth().signInAnonymously() { (authResult, error) in
                
            }
            
            Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(segueToTutorial), userInfo: nil, repeats: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func sequeToMainMenu() {
        self.performSegue(withIdentifier: "segueSplashToMainMenu", sender: self)
    }
    
    @objc func segueToTutorial() {
        self.performSegue(withIdentifier: "segueSplashToTutorial", sender: self)
    }
}

