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

    @IBOutlet weak var videoWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoWebView.allowsInlineMediaPlayback = true
        self.videoWebView.loadRequest(URLRequest(url: URL(string: "https://www.youtube.com/embed/cYARzDsOJjY")!))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
