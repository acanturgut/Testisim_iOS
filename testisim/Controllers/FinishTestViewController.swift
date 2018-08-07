//
//  FinishTestViewController.swift
//  testisim
//
//  Created by Ahmet Can on 7.08.2018.
//  Copyright © 2018 Testisim. All rights reserved.
//

import UIKit

class FinishTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onNoButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "testEndToNoResult", sender: self)
    }
    
    @IBAction func onYesButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "testEndToYesResult", sender: self)
    }
}
