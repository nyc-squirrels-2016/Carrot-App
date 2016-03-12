//
//  ViewController.swift
//  Carrot-App-3
//
//  Created by Apprentice on 3/11/16.
//  Copyright © 2016 Apprentice. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder:AVAudioRecorder!
    var receivedAudio: RecordedAudio!


    @IBAction func recordButtonTapped() {
        print("Start Recording")
        
        // Where do I want to save the recording... Assume this is like working with DIR in ruby
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let recordingName = "fudge.wav"
        let pathArray = [dirPath, recordingName]
        
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        print(audioRecorder.peakPowerForChannel(0)) //Adding in for testing. To not remain (at least for now) in this function.
        print(audioRecorder.recordForDuration(5))
        print(audioRecorder.peakPowerForChannel(0)) //Adding in for testing. To not remain (at least for now) in this function.
        print(audioRecorder.stop()) //Adding in for testing. To not remain (at least for now) in this function.
        print(audioRecorder.peakPowerForChannel(0)) //Adding in for testing. To not remain (at least for now) in this function.
        print("RECORDING BITCHESSSSSSSS FUCK")
        
        
    }

    @IBAction func stopRecording() {
        audioRecorder.stop()
        
        print(audioRecorder.peakPowerForChannel(0))
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        print("Stopping recording")
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

