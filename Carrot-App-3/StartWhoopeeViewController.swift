//
//  StartWhoopeeViewController.swift
//  Carrot-App-3
//
//  Created by Apprentice on 3/15/16.
//  Copyright © 2016 Apprentice. All rights reserved.
//

import UIKit

class StartWhoopeeViewController: UIViewController {
    
    @IBOutlet weak var startingWhoopee: UIImageView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startingWhoopee.hidden = true
        delay(1.0){
            self.startingWhoopee.hidden = false
            self.delay(0.5){
                self.startingWhoopee.hidden = true
                self.delay(0.5){
                    self.startingWhoopee.hidden = false
                }
            }
        }
        
    }

}
