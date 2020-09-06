//
//  VideoViewController.swift
//  testisim
//
//  Created by Ahmet Can on 8.08.2018.
//  Copyright © 2018 Testisim. All rights reserved.
//

import UIKit
import WebKit

class VideoViewController: UIViewController {

    @IBOutlet weak var videoWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       let myURL = URL(string: "https://www.youtube.com/embed/cYARzDsOJjY?playsinline=1")
        let youtubeRequest = URLRequest(url: myURL!)
       videoWebView.load(youtubeRequest)
  
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
