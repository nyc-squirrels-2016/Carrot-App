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
    
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    var roomAverage: Float = 0.0

    @IBAction func recordButtonTapped() {
//        print("Start Recording")
//        
//        // Where do I want to save the recording... Assume this is like working with DIR in ruby
//        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
//        let filePath = NSURL.fileURLWithPath(dirPath)
//        
//        let session = AVAudioSession.sharedInstance()
//
////        let recordSettings:[String : AnyObject] = [
////            AVFormatIDKey: NSNumber(unsignedInt:kAudioFormatAppleLossless),
////            AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
////            AVEncoderBitRateKey : 320000,
////            AVNumberOfChannelsKey: 2,
////            AVSampleRateKey : 44100.0
////        ]
////        //        print(filePath)
////        print(recordSettings)
//
//        
//        try! session.setCategory(AVAudioSessionCategoryRecord)
//        try! audioRecorder = AVAudioRecorder(URL: filePath, settings: [:])
//        
//        audioRecorder.delegate = self
//        audioRecorder.meteringEnabled = true
//        audioRecorder.prepareToRecord()
//        audioRecorder.record()
//        print("RECORDING")
        let audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        
        if(audioSession.respondsToSelector("requestRecordPermission:")){
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool) -> Void in
                if granted {
                    try! audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
                    try! audioSession.setActive(true)
                    let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
                    let fileName = "my_audio.caf"
                    let pathArray = [documentsDirectory, fileName]
                    let url = NSURL.fileURLWithPathComponents(pathArray)
                    
                    //create AnyObject of settings
                    let settings: [String : AnyObject] = [
                        
                        AVFormatIDKey:Int(kAudioFormatAppleIMA4), //Int required in Swift2
                        AVSampleRateKey:44100.0,
                        AVNumberOfChannelsKey:1,
                        AVEncoderBitRateKey:12800,
                        AVLinearPCMBitDepthKey:16,
                        AVEncoderAudioQualityKey:AVAudioQuality.Max.rawValue
                    ]
                    
                    //record
                    try! self.audioRecorder = AVAudioRecorder(URL: url!, settings: settings)
                    self.audioRecorder.meteringEnabled = true
                    self.audioRecorder.recordForDuration(3)
                    sleep(4)
                    self.audioRecorder.updateMeters()
                    
                    self.roomAverage = self.audioRecorder.averagePowerForChannel(0)
                    
                    print(self.roomAverage)
                    // prepareToRecord
                    // setMeteringEnabled
                    // record
                    // updateMeters
                    // peak or avg power
                    
                }else{print("booo")}
            })
        }
        
    }
    
    
    
//    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
//        if flag {
//            //Save the recorded audio
//            recordedAudio = RecordedAudio(filePathURL: recorder.url, title: recorder.url.lastPathComponent!)
//            //Perform a segue to next scene
//            print("Okie Dokie")
//        } else {
//            print("Recording was not successful")
//        }
//    }

    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

