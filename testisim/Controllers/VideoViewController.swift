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
        
            self.videoWebView.loadHTMLString("<body style='background-color: black; margin:0px;'><iframe width=\"\(videoWebView.frame.width)\" height=\"\(videoWebView.frame.height)\" src=\"https://www.youtube.com/embed/V9J7l0eWXSs?rel=0&amp;showinfo=0\" frameborder=\"0\" allowfullscreen></iframe></body>", baseURL: nil)
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
