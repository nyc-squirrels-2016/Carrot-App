//
//  NoAnimationViewController.swift
//  Carrot-App-3
//
//  Created by Apprentice on 3/15/16.
//  Copyright © 2016 Apprentice. All rights reserved.
//

import UIKit

class NoAnimationViewController: UIViewController {
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }

    

}
