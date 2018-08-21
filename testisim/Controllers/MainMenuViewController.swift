//
//  MainMenuViewController.swift
//  testisim
//
//  Created by Ahmet Can on 5.08.2018.
//  Copyright © 2018 Testisim. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var remainingTimeText: UILabel!
    @IBOutlet weak var modelViewCanceller: UIView!
    @IBOutlet weak var voiceControlView: RoundedUIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modelViewCanceller.isHidden = true
        voiceControlView.isHidden = true
        remainingTimeText.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onShareButtonClicked(_ sender: Any) {
        
        let text = "Testisim App Paylaş... Link <a href=\"\">Link</a>"
        
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    @IBAction func onStartActionButtonClicked(_ sender: Any) {
        
        TestisimRunTimeMemory.isInVoiceControlMode = false
        performSegue(withIdentifier: "startTestSegue", sender: self)
    }
    
    @IBAction func cancelModelView(_ sender: Any) {
        
        modelViewCanceller.isHidden = true
        voiceControlView.isHidden = true
    }
    @IBAction func onWorkWithActionButtonClicked(_ sender: Any) {
        voiceControlView.isHidden = false
        modelViewCanceller.isHidden = false
    }
    
    @IBAction func onStartTestButtonClickedWithVoiceControlled(_ sender: Any) {
        
        TestisimRunTimeMemory.isInVoiceControlMode = true
        modelViewCanceller.isHidden = true
        voiceControlView.isHidden = true
        
        performSegue(withIdentifier: "startTestSegue", sender: self)
        
    }
}
