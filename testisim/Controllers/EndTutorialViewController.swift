//
//  EndTutorialViewController.swift
//  testisim
//
//  Created by Ahmet Can on 4.08.2018.
//  Copyright © 2018 Testisim. All rights reserved.
//

import UIKit

class EndTutorialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    
    @IBAction func continueButtonOnClick(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.IS_USER_COMPLATE_TUTORIALS)
        performSegue(withIdentifier: "segueTutorialToMainMenu", sender: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
