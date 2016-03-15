//
//  PlayBoomBoxViewController.swift
//  Carrot-App-3
//
//  Created by Apprentice on 3/15/16.
//  Copyright © 2016 Apprentice. All rights reserved.
//

import UIKit

class PlayBoomBoxViewController: UIViewController {
    
    @IBOutlet weak var playingBoomBox: UIImageView!
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playingBoomBox.hidden = true
        delay(1.0){
            self.playingBoomBox.hidden = false
            self.delay(0.5){
                self.playingBoomBox.hidden = true
                self.delay(0.5){
                    self.playingBoomBox.hidden = false
                }
            }
        }
        
    }

}
