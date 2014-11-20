//
//  StartController.swift
//  SCAND
//
//  Created by Sagepath on 11/19/14.
//  Copyright (c) 2014 Sagepath. All rights reserved.
//

import UIKit
import MediaPlayer

@IBDesignable class StartController: BaseScanDController {
    
    @IBInspectable var startToDashBoardSegueIdentifier: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func StartButtonTouched(sender: AnyObject) {
        self.transitionToViewControllerBySegueIdentifier(startToDashBoardSegueIdentifier)
    }
    
    
    
}

