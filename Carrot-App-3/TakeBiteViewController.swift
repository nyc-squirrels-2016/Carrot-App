//
//  TakeBiteViewController.swift
//  Carrot-App-3
//
//  Created by Apprentice on 3/14/16.
//  Copyright © 2016 Apprentice. All rights reserved.
//

import UIKit

class TakeBiteViewController: UIViewController {


    
    @IBOutlet weak var carrot0: UIImageView!
    @IBOutlet weak var carrot1: UIImageView!
    @IBOutlet weak var carrot2: UIImageView!
    @IBOutlet weak var carrot3: UIImageView!
    @IBOutlet weak var carrot4: UIImageView!
    @IBOutlet weak var carrot5: UIImageView!
    @IBOutlet weak var carrot6: UIImageView!
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delay(1.0){
            self.biteCarrot()
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func biteCarrot(){
        self.carrot0.hidden = true
        self.delay(0.25) {
            self.carrot1.hidden = true
            self.delay(0.25){
                self.carrot2.hidden = true
                self.delay(0.25){
                    self.carrot3.hidden = true
                    self.delay(0.25){
                        self.carrot4.hidden = true
                        self.delay(0.25){
                            self.carrot5.hidden = true
                        }
                    }
                }
            }
        }
    }
}
