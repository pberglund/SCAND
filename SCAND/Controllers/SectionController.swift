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
        populateArrowViews()
        
    }
    
    deinit{
        println("DeInit: SectionController -  \(self.pageIdentifier)")
        //downArrowView.removeFromSuperview();
        //upArrowView.removeFromSuperview();
    }
    
    func populateArrowViews(){
        weak var weakSelf = self;
        
        var downArrowBase = UIImage(named:"_SCAND_dashboard_templates_Manufacturer_snapshot_03")
        //let downArrowDimensions = CGSize(width: 47, height: 30)
        //var downArrrowResized = RBResizeImage(downArrowBase!, targetSize: downArrowDimensions)
        var downArrowImageView = UIImageView(image: downArrowBase) as UIImageView?
        
        var downFrame = CGRect(x: 489, y: 707, width: 47, height: 30)
        downArrowView = UIView(frame: downFrame)
        
        
        //downArrowView.backgroundColor = UIColor.clearColor()
        
        downArrowView.addSubview(downArrowImageView!)
        
        downArrowView.alpha = 1.0;
        weakSelf!.sliderView.addSubview(downArrowView)
        
        downArrowBase = nil
        //downArrrowResized = nil
        downArrowImageView = nil
        
        var upArrowBase = UIImage(named:"_SCAND_dashboard_templates_Manufacturer_snapshot_06")
        //let upArrowDimensions = CGSize(width: 47, height: 30)
        //var upArrrowResized = RBResizeImage(upArrowBase!, targetSize: upArrowDimensions)
        var upArrowImageView = UIImageView(image: upArrowBase) as UIImageView?
        
        var upFrame = CGRect(x: 489, y: 788, width: 47, height: 30)
        upArrowView = UIView(frame: upFrame)
        
        //downArrowView.backgroundColor = UIColor.clearColor()
        
        upArrowView.addSubview(upArrowImageView!)
        
        upArrowView.alpha = 0.0;
        weakSelf!.sliderView.addSubview(upArrowView)
        
        upArrowBase = nil
        //upArrrowResized = nil
        upArrowImageView = nil
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    
    
    
}