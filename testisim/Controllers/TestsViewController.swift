//
//  TestsViewController.swift
//  testisim
//
//  Created by Ahmet Can on 19.08.2018.
//  Copyright © 2018 Testisim. All rights reserved.
//

import UIKit

class TestsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tests: [Test] = []
    
    @IBOutlet weak var testsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPlaces()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadPlaces() {
        guard let testData = UserDefaults.standard.object(forKey: UserDefaultsKeys.USER_TEST_DATA) as? NSData else {
            print("'tests' not found in UserDefaults")
            return
        }
        
        guard let tests = NSKeyedUnarchiver.unarchiveObject(with: testData as Data) as? [Test] else {
            print("Could not unarchive from testData")
            return
        }
        
        for test in tests {
            self.tests.append(test)
        }
        
        self.tests = self.tests.reversed()
        
        testsTableView.reloadData()
        
    }
    
    //     - MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let testCell = tableView.dequeueReusableCell(withIdentifier: "testTableCell", for: indexPath) as! TestTableViewCell
        
        
        if (!tests.isEmpty) {
            
            testCell.testImage.image = (tests[indexPath.row].status ? #imageLiteral(resourceName: "yes") :  #imageLiteral(resourceName: "no"))
          testCell.testText.text = tests[indexPath.row].date
        }
        
        return testCell
    }
}
