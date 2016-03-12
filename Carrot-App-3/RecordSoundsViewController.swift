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
    
    @IBOutlet weak var rotatingCarrot: UIImageView!
    @IBOutlet weak var eatTheCarrot: UILabel!
    @IBOutlet weak var dontEatTheCarrot: UILabel!

    @IBOutlet weak var listenButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    var roomAverage: Float = 0.0
    let rotate = [
        UIImage(named: "carrot-2")!,
        UIImage(named: "carrot-3")!,
        UIImage(named: "carrot-4")!,
        UIImage(named: "carrot-5")!,
        UIImage(named: "carrot-6")!,
        UIImage(named: "carrot-7")!,
        UIImage(named: "carrot-8")!,
        UIImage(named: "carrot-9")!,
        UIImage(named: "carrot-10")!,
        UIImage(named: "carrot-11")!,
        UIImage(named: "carrot-12")!,
        UIImage(named: "carrot-13")!,
        UIImage(named: "carrot-14")!,
        UIImage(named: "carrot-15")!,
        UIImage(named: "carrot-16")!
    ]
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eatTheCarrot.hidden = true
        dontEatTheCarrot.hidden = true
        rotatingCarrot.hidden = true
        rotatingCarrot.image = rotate[index++]
    }
    
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
//                    sleep(4)
                    self.hideButton()
                    self.animateRotation()
                    
                    self.audioRecorder.updateMeters()
                    
                    self.roomAverage = self.audioRecorder.averagePowerForChannel(0)
                    
                    self.flowTest()
                    // prepareToRecord
                    // setMeteringEnabled
                    // record
                    // updateMeters
                    // peak or avg power
                    
                }else{print("booo")}
            })
        }
    }
    
    func hideButton(){
        let timer:Double = 0.25
        NSThread.sleepForTimeInterval(timer)
        listenButton.hidden = true
        rotatingCarrot.hidden = false
    }
    
    func animateRotation(){
        CATransaction.begin()
        let animationDuration: NSTimeInterval = 0.25
        let switchingInterval: NSTimeInterval = 4
    
        CATransaction.setAnimationDuration(animationDuration)
        CATransaction.setCompletionBlock {
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(switchingInterval * NSTimeInterval(NSEC_PER_SEC)))
            dispatch_after(delay, dispatch_get_main_queue()) {
                self.animateRotation()
            }
        }
        let transition = CATransition()
        transition.type = kCATransitionFade
        rotatingCarrot.layer.addAnimation(transition, forKey: kCATransition)
        rotatingCarrot.image = rotate[index]
    }
    
    func flowTest()  {
        print("Now in control flow")
        if self.roomAverage > -20 {
            print("Eat")
            eatTheCarrot.hidden = false
        } else {
            print("Don't")
            dontEatTheCarrot.hidden = false
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

