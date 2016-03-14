//
//  DontEatViewController.swift
//  Carrot-App-3
//
//  Created by Apprentice on 3/14/16.
//  Copyright © 2016 Apprentice. All rights reserved.
//

import UIKit

class DontEatViewController: UIViewController {

    
    @IBOutlet weak var dontEatCarrot: UIImageView!
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.delay(1.0){
            self.animateCarrot()
            self.delay(1.75){
                self.animateCarrot()
            }
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
    

    
    func animateCarrot(duration: CFTimeInterval = 0.75, completionDelegate: AnyObject? = nil){
//        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
//        rotateAnimation.fromValue = 0.0
//        rotateAnimation.toValue = CGFloat(M_PI_2)
//        sleep(1)
//        rotateAnimation.fromValue = CGFloat(M_PI_2)
//        rotateAnimation.toValue = 0.0
//        rotateAnimation.duration = duration
//        
////        if let delegate: AnyObject = completionDelegate{
////            rotateAnimation.delegate = delegate
////        }
//        dontEatCarrot.layer.addAnimation(rotateAnimation, forKey: nil)
        
        UIView.animateWithDuration(1.0, animations:{ () -> Void in
            self.dontEatCarrot.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        })
        UIView.animateWithDuration(1.0, delay: 0.75, options: UIViewAnimationOptions.CurveEaseIn, animations:{ () -> Void in
            self.dontEatCarrot.transform = CGAffineTransformMakeRotation(CGFloat(-0.0))
            }, completion: nil)
        }

}
