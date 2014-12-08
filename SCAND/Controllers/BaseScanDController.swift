//
//  BaseScanDController.swift
//  SCAND
//
//  Created by Sagepath on 11/18/14.
//  Copyright (c) 2014 Sagepath. All rights reserved.
//

//
//  BaseUiViewController.swift
//  SingleView
//
//  Created by Sage Path on 11/14/14.
//  Copyright (c) 2014 Sage Path. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class BaseScanDController : BaseViewController{
    
    let menuIdentifier = "menuPage"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackGroundImage()
        
        if(pageIdentifier != nil && pageIdentifier == menuIdentifier){
            //println("On menu")
            return
        }
        
        self.addMenuButton()
        
    }
    
        
}
