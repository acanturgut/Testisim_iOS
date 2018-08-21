//
//  ThirdTestPageViewController.swift
//  testisim
//
//  Created by Ahmet Can on 21.08.2018.
//  Copyright © 2018 Testisim. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ThirdTestPageViewController: UIViewController, AVSpeechSynthesizerDelegate {
   
    @IBOutlet weak var firstText: UILabel!
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        synth.stopSpeaking(at: AVSpeechBoundary(rawValue: 0)!)
    }
    
    @objc func speakToMe(){
        
        cancelRecording()
        
        if synth.isSpeaking {
            
            synth.stopSpeaking(at: AVSpeechBoundary.immediate)
            
        }else{
            
            myUtterance = AVSpeechUtterance(string: "\(String(describing: firstText.text)) Devam etmek için devam diyebilir yada sonlandır diyerek ana sayfaya dönebilirsin.")
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
                
                if(self.memorySpeach.lowercased().contains("devam")){
                    
                    self.audioEngine.stop()
                    
                    self.recognitionTask?.cancel()
                    self.recognitionTask?.finish()
                    
                    do {
                        try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
                    } catch _ {}
                    
                    self.performSegue(withIdentifier: "segueTestThreeToEnd", sender: self)
                    
                }else if self.memorySpeach.lowercased().contains("sonlandır") {
                    
                    self.audioEngine.stop()
                    
                    self.recognitionTask?.cancel()
                    
                    self.recognitionTask?.finish()
                    
                    do {
                        try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
                    } catch _ {
                    }
                    
                    self.performSegue(withIdentifier: "segueThirdTestScreenToMainMenu", sender: self)
                    
                }
                
            } else if let error = error {
                print(error)
            }
        })
    }


}
