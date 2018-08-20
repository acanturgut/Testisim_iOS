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
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func onNoButtonClicked(_ sender: Any) {
        saveRecord(status: false)
        self.performSegue(withIdentifier: "testEndToNoResult", sender: self)
    }
    
    @IBAction func onYesButtonClicked(_ sender: Any) {
        saveRecord(status: true)
        self.performSegue(withIdentifier: "testEndToYesResult", sender: self)
    }
    
    
    func saveRecord(status: Bool) {
      
        guard let placesData = UserDefaults.standard.object(forKey: UserDefaultsKeys.USER_TEST_DATA) as? NSData else {
            print("'Tests' not found in UserDefaults")
            
            let placesArray: [Test] = [Test(date: TestisimDateFormaterUtil().getCurrentDate(), status: status)]
            
            let placesDataHold = NSKeyedArchiver.archivedData(withRootObject: placesArray)
            UserDefaults.standard.set(placesDataHold, forKey: UserDefaultsKeys.USER_TEST_DATA)
            return
        }
        
        guard var placesArray = NSKeyedUnarchiver.unarchiveObject(with: placesData as Data) as? [Test] else {
            print("Could not unarchive from TestData")
            return
        }
        
        placesArray.append(Test(date: TestisimDateFormaterUtil().getCurrentDate(), status: status))
        
        let placesDataHold = NSKeyedArchiver.archivedData(withRootObject: placesArray)
        UserDefaults.standard.set(placesDataHold, forKey: UserDefaultsKeys.USER_TEST_DATA)
    }
}
