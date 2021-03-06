//
//  FinishTestViewController.swift
//  testisim
//
//  Created by Ahmet Can on 7.08.2018.
//  Copyright © 2018 Testisim. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class FinishTestViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
    let audioEngine = AVAudioEngine()
    
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale.init(identifier: "tr-TR"))
    var myUtterance = AVSpeechUtterance(string: "")
    let audioSession = AVAudioSession.sharedInstance()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
    let synth = AVSpeechSynthesizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        synth.delegate = self as AVSpeechSynthesizerDelegate
        
        // SYNTH
        
        if(TestisimRunTimeMemory.isInVoiceControlMode) {
            
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(speakToMe), userInfo: nil, repeats: false)
        }
    }
    
    @objc func speakToMe(){
        
        cancelRecording()
        
        if synth.isSpeaking {
            
            synth.stopSpeaking(at: AVSpeechBoundary.immediate)
            
        }else{
            
            myUtterance = AVSpeechUtterance(string: "Testisleriniz sağllıklı mı? Evet veya Hayır cevabı vererek devam edebilirsiniz?")
            myUtterance.voice = AVSpeechSynthesisVoice(language: "tr-TR")
            myUtterance.rate = 0.52
            synth.speak(myUtterance)
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        
        if(TestisimRunTimeMemory.isInVoiceControlMode) {
            startRecording()
        }
    }
    
    func cancelRecording() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
    }
    
    var memorySpeach: String = "none"
    
    func startRecording() {
        
        
        let node = audioEngine.inputNode
        
        let recordingFormat = node.outputFormat(forBus: 0)
        
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
            
        } catch {
            return print(error)
        }
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if let result = result {
                
                self.memorySpeach = result.bestTranscription.formattedString
                
                print("DEBUGGER: --> \(self.memorySpeach)")
                
                if(self.memorySpeach.lowercased().contains("evet")){
                    
                    self.audioEngine.stop()
                    
                    self.recognitionTask?.cancel()
                    self.recognitionTask?.finish()
                    
                    do {
                        try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
                    } catch _ {}
                    
                    self.saveRecord(status: true)
                    self.performSegue(withIdentifier: "testEndToYesResult", sender: self)
                    
                }else if self.memorySpeach.lowercased().contains("hayır") {
                    
                    self.audioEngine.stop()
                    
                    self.recognitionTask?.cancel()
                    
                    self.recognitionTask?.finish()
                    
                    do {
                        try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
                    } catch _ {
                    }
                    
                    self.saveRecord(status: false)
                    self.performSegue(withIdentifier: "testEndToNoResult", sender: self)
                    
                }
                
            } else if let error = error {
                print(error)
            }
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        synth.stopSpeaking(at: AVSpeechBoundary(rawValue: 0)!)
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
