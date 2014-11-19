//
//  SectionController.swift
//  SCAND
//
//  Created by Sagepath on 11/19/14.
//  Copyright (c) 2014 Sagepath. All rights reserved.
//

import UIKit
import MediaPlayer

@IBDesignable class SectionController: BaseScanDController {
    
    //@IBInspectable var leftView: String!
    
    @IBInspectable var rightView: String!
    
    @IBInspectable var videoPath: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func rightArrowButton(sender: AnyObject) {
        println("Clicked right arrow, going to: \(rightView)")
        self.transitionToViewControllerByStoryboardId(rightView)
    }
    
    /*
@IBAction func leftArrowButton(sender: AnyObject) {

        println("Clicked left arrow, going to: \(leftView)")
        self.transitionToViewControllerByStoryboardId(leftView)
    }
*/
    @IBAction func playArrowButton(sender: AnyObject) {
    }
}
