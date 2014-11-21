//
//  SectionController.swift
//  SCAND
//
//  Created by Sagepath on 11/19/14.
//  Copyright (c) 2014 Sagepath. All rights reserved.
//

import UIKit
import MediaPlayer

class SectionController: SectionBaseController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let downArrowBase = UIImage(named: "_SCAND_dashboard_templates_Manufacturer_snapshot_03")
        let downArrowDimensions = CGSize(width: 47, height: 30)
        let downArrrowResized = RBResizeImage(downArrowBase!, targetSize: downArrowDimensions)
        let downArrowImageView = UIImageView(image: downArrrowResized)
        
        var downFrame = CGRect(x: 489, y: 707, width: 47, height: 30)
        downArrowView = UIView(frame: downFrame)
        
        //downArrowView.backgroundColor = UIColor.clearColor()
        
        downArrowView.addSubview(downArrowImageView)
        
        downArrowView.alpha = 1.0;
        self.sliderView.addSubview(downArrowView)
        
        let upArrowBase = UIImage(named: "_SCAND_dashboard_templates_Manufacturer_snapshot_06")
        let upArrowDimensions = CGSize(width: 47, height: 30)
        let upArrrowResized = RBResizeImage(upArrowBase!, targetSize: upArrowDimensions)
        let upArrowImageView = UIImageView(image: upArrrowResized)
        
        var upFrame = CGRect(x: 489, y: 788, width: 47, height: 30)
        upArrowView = UIView(frame: upFrame)
        
        //downArrowView.backgroundColor = UIColor.clearColor()
        
        upArrowView.addSubview(upArrowImageView)
        
        upArrowView.alpha = 0.0;
        self.sliderView.addSubview(upArrowView)
        //self.downArrowView.alpha = 0.0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}