//
//  SplashViewController.swift
//  testisim
//
//  Created by Ahmet Can on 31.07.2018.
//  Copyright © 2018 Testisim. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ( UserDefaults.standard.bool(forKey: UserDefaultsKeys.IS_USER_COMPLATE_TUTORIALS)) {
            Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(sequeToMainMenu), userInfo: nil, repeats: false)
        } else {
            Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(segueToTutorial), userInfo: nil, repeats: false)
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

