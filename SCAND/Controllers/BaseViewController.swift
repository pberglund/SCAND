//
//  BaseUiViewController.swift
//  SingleView
//
//  Created by Sage Path on 11/14/14.
//  Copyright (c) 2014 Sage Path. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class BaseViewController : UIViewController{
    
    let transitionManager = TransitionManager()
    
    @IBInspectable var backgroundImageFileName:String!
    //@IBInspectable var menuButtonImageFileName:String!
    @IBInspectable var pageIdentifier: String!
        
    enum Direction {
        case Up
        case Down
        case Left
        case Right
        case None
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackGroundImage()
        addMenuButton()
    }
    
    func setBackGroundImage(){
        if(backgroundImageFileName == nil){
            return
        }
        
        let image = UIImage(named: backgroundImageFileName) as UIImage?
        let resized = RBResizeImage(image!, targetSize: self.view.bounds.size)
        
        self.view.backgroundColor = UIColor(patternImage: resized)
    }
    
    func addMenuButton(){
        
        //if(menuButtonImageFileName == nil){
        //    return
        //}
        
        //let image = UIImage(named: menuButtonImageFileName) as UIImage?
        let button   = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRectMake(960, 25, 40, 35)
        //button.setImage(image, forState: .Normal)
        button.addTarget(self, action: "btnTouched:", forControlEvents:.TouchUpInside)

        self.view.addSubview(button)

    }
    
    func btnTouched(sender:UIButton!)
    {
        transitionToViewControllerByStoryboardId("MenuPage")
        
        println("Menu Button tapped")
    }

    
    func transitionToViewControllerBySegueIdentifier(segueIdentifier:String, originPage:String = ""){
        
        var origin = originPage;
        
        if(origin == ""){
            if(pageIdentifier == nil){
                origin = self.description;
            }
            else{
                origin = pageIdentifier
            }
        }
        
        self.performSegueWithIdentifier(segueIdentifier, sender: self)
        println("Self: \(origin), Transition: \(segueIdentifier)")

    }
    
    func transitionToViewControllerByStoryboardId(storyBoardId:String){
    
        let vc : UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier(storyBoardId) as UIViewController
        vc.transitioningDelegate = self.transitionManager
        self.showViewController(vc, sender: vc)
    
    }
    
    func RBResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

}