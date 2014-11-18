//
//  DashBoardController.swift
//  SCAND
//
//  Created by Sagepath on 11/18/14.
//  Copyright (c) 2014 Sagepath. All rights reserved.
//

import UIKit
import MediaPlayer

@IBDesignable class DashboardController: BaseViewController {
    
    @IBInspectable var categoryPerformanceSegueIdentifier: String!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func categoryPerformanceButtonTouchUpInside(sender: AnyObject) {
        self.transitionToViewControllerBySegueIdentifier(categoryPerformanceSegueIdentifier)
    }
    
    
    
}


