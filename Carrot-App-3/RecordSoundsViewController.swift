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
    @IBOutlet weak var chooseCarrot: UIButton!
    @IBOutlet weak var chooseBoomBox: UIButton!
    @IBOutlet weak var chooseWhoopee: UIButton!
    @IBOutlet weak var carrotLabel: UILabel!
    @IBOutlet weak var boomBoxLabel: UILabel!
    @IBOutlet weak var whoopeeLabel: UILabel!
    
    
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    var roomAverage: Float = 0.0
    var objectAverage: Int = -30
    var object = "carrot"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listeningLabel.hidden = true
        boomBoxLabel.hidden = true
        whoopeeLabel.hidden = true
        carrotLabel.adjustsFontSizeToFitWidth = true
        carrotLabel.minimumScaleFactor = 0.2
        boomBoxLabel.adjustsFontSizeToFitWidth = true
        boomBoxLabel.minimumScaleFactor = 0.2
        whoopeeLabel.adjustsFontSizeToFitWidth = true
        whoopeeLabel.minimumScaleFactor = 0.2
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
    
    @IBAction func pickCarrot() {
        self.objectAverage = -30
        let carrot = UIImage(named: "carrot-img.png")
        self.listenButton.setImage(carrot, forState: .Normal)
        self.object = "carrot"
        carrotLabel.hidden = false
        boomBoxLabel.hidden = true
        whoopeeLabel.hidden = true
    }
    
    
    @IBAction func pickBoomBox() {
        self.objectAverage = -3
        let boomBox = UIImage(named: "boombox1.png")
        self.listenButton.setImage(boomBox, forState: .Normal)
        self.object = "boombox"
        carrotLabel.hidden = true
        boomBoxLabel.hidden = false
        whoopeeLabel.hidden = true
        
    }
    
    
    @IBAction func pickWhoopee() {
        self.objectAverage = -35
        let whoopee = UIImage(named: "whoopee1.png")
        self.listenButton.setImage(whoopee, forState: .Normal)
        self.object = "whoopee"
        carrotLabel.hidden = true
        boomBoxLabel.hidden = true
        whoopeeLabel.hidden = false
    }
    
//    @IBAction func pickWhoopee() {
//        self.objectAverage = -40
//        let whoopee = UIImage(named: "whoopee0.png")
//        self.listenButton.setImage(whoopee, forState: .Normal)
//    }
    
    
    
    
    
    @IBAction func recordButtonTapped() {
        
        chooseCarrot.hidden = true
        chooseBoomBox.hidden = true
        chooseWhoopee.hidden = true
        
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
                    self.audioRecorder.meteringEnabled = true
                    self.audioRecorder.record()
//                    NSThread.sleepForTimeInterval(0.5) // Replace with delay and include all the functions between here and the second delay.
                    self.delay(1.0){
                        self.audioRecorder.updateMeters()
                        self.audioRecorder.stop()
                        self.audioRecorder.averagePowerForChannel(0)
                        //print(self.audioRecorder.averagePowerForChannel(0)
                        self.roomAverage = self.audioRecorder.averagePowerForChannel(0)
                        self.delay(2.5) {
                            self.flowTest()
                        }
                    }
                    
                }else {
                    //print("Recording Failed")
                    // Add error handling or at the very least error messaging
                }
            })
        }
    }
    
    
    
    func flowTest()  {
        if self.object == "carrot" {
            if CGFloat(self.roomAverage) > CGFloat(self.objectAverage) {
                self.performSegueWithIdentifier("toTakeaBite", sender: self)
            } else {
                self.performSegueWithIdentifier("toDontEat", sender: self)
            }
        } else if self.object == "boombox" {
            if CGFloat(self.roomAverage) > CGFloat(self.objectAverage) {
                self.performSegueWithIdentifier("toPlayBoomBox", sender: self)
            } else {
                self.performSegueWithIdentifier("toDontPlayBoomBox", sender: self)
            }
        } else if self.object == "whoopee" {
            if CGFloat(self.roomAverage) > CGFloat(self.objectAverage){
                self.performSegueWithIdentifier("toStartWhoopee", sender: self)
            } else {
                self.performSegueWithIdentifier("toDontWhoopee", sender: self)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

