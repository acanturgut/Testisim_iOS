//
//  TutorialViewController.swift
//  testisim
//
//  Created by Ahmet Can on 21.08.2018.
//  Copyright © 2018 Testisim. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image : UIImage = #imageLiteral(resourceName: "logoHeader")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
