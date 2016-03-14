//
//  ViewController.swift
//  Carrot-App-3
//
//  Created by Apprentice on 3/11/16.
//  Copyright © 2016 Apprentice. All rights reserved.
//

import UIKit
import AVFoundation
import QuartzCore

class ViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var listenButton: UIButton!
    @IBOutlet weak var listeningLabel: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    var roomAverage: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listeningLabel.hidden = true
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    @IBAction func recordButtonTapped() {
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
                    self.listeningLabel.hidden = false
                    //record
                    try! self.audioRecorder = AVAudioRecorder(URL: url!, settings: settings)
                    UIView.animateWithDuration(2.0, animations:{ () -> Void in
                        self.listenButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                    })
                    UIView.animateWithDuration(2.0, delay: 0.5, options: UIViewAnimationOptions.CurveEaseIn, animations:{ () -> Void in
                        self.listenButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI * 2))
                    }, completion: nil)
//                    self.hideButton()
//                    self.animateRotation()
                    self.audioRecorder.meteringEnabled = true
                    self.audioRecorder.record()
                    NSThread.sleepForTimeInterval(0.5) // Replace with delay and include all the functions between here and the second delay.
                    self.audioRecorder.updateMeters()
                    self.audioRecorder.stop()
                    print(self.audioRecorder.averagePowerForChannel(0))
                    self.roomAverage = self.audioRecorder.averagePowerForChannel(0)
                    self.delay(2.5) {
                        self.flowTest()
                    }
                    // prepareToRecord
                    // setMeteringEnabled
                    // record
                    // updateMeters
                    // peak or avg power
                    
                }else {
                    print("Recording Failed")
                    // Add error handling or at the very least error messaging
                }
            })
        }
    }
    
    func flowTest()  {
        print("Now in control flow")
        if self.roomAverage > -30 {
            print("Eat") //Delete Later
            self.performSegueWithIdentifier("toTakeaBite", sender: self)
        } else {
            print("Don't") //Delete Later
            self.performSegueWithIdentifier("toDontEat", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

