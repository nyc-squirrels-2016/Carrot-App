//
//  PlaySoundsViewController.swift
//  Carrot-App-3
//
//  Created by Apprentice on 3/11/16.
//  Copyright © 2016 Apprentice. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController, AVAudioPlayerDelegate {

    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(receivedAudio.filePathURL)
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL) // Written Post-ZACK
        audioPlayer.enableRate = true // Written Post-ZACK
        audioEngine = AVAudioEngine() // Written Post-ZACK
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathURL) // Written Post-ZACK
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func stopAndResetAudio() {
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
    }
    
    @IBAction func tappedPlayback() {
        do{
            stopAndResetAudio()
            //        audioPlayer =  try! AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: "file:///var/mobile/Containers/Data/Application/3BF9CBB8-10C8-48A1-98B5-E8CC9E2541F5/Documents/fudge.wav"))
            //        stopAndResetAudio()
            audioPlayer.rate = 1.0
            audioPlayer.currentTime = 0
            print("PLAY THIS")
            audioPlayer.play()
        }
    }
}