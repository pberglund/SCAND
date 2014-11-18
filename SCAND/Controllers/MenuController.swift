//
//  MenuController.swift
//  SCAND
//
//  Created by Sagepath on 11/18/14.
//  Copyright (c) 2014 Sagepath. All rights reserved.
//

import UIKit
import MediaPlayer

@IBDesignable class MenuController: BaseViewController {
    
    var returnStoryBoardId:String!
    var transManager:TransitionManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCloseMenuButton();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addCloseMenuButton(){
        
        //if(menuButtonImageFileName == nil){
        //    return
        //}
        
        //let image = UIImage(named: menuButtonImageFileName) as UIImage?
        //let button   = UIButton.buttonWithType(UIButtonType.System) as UIButton
        //button.frame = CGRectMake(960, 25, 40, 35)
        //button.setImage(image, forState: .Normal)
        //button.addTarget(self, action: "closedBtnTouched:", forControlEvents:.TouchUpInside)
        
        //self.view.addSubview(button)
        
    }
    
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        // empty for now
    }
    
    func closedBtnTouched(sender:UIButton!)
    {

        println("Close Button tapped")
        
        if(returnStoryBoardId == nil || returnStoryBoardId == ""){
            println("Error returning to previous controller, returnStoryBoardId was null")
            return;
        }
        
        self.transitionToViewControllerByStoryboardId(returnStoryBoardId)
        

    }

    
    
    
    
}


