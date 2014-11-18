//
//  BaseUiViewController.swift
//  SingleView
//
//  Created by Sage Path on 11/14/14.
//  Copyright (c) 2014 Sage Path. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController : UIViewController{
    enum Direction {
        case Up
        case Down
        case Left
        case Right
        case None
    }
    
    func transitionToViewControllerBySegueIdentifier(segueIdentifier:String, originPage:String = ""){
        
        var origin = originPage;
        
        if(originPage == ""){
            origin = self.description;
        }
        
        self.performSegueWithIdentifier(segueIdentifier, sender: self)
        println("Self: \(origin), Transition: \(segueIdentifier)")

    }
    
    func transitionToViewControllerByStoryboardId(storyBoardId:String){
    
        let vc : AnyObject? = self.storyboard?.instantiateViewControllerWithIdentifier(storyBoardId)
        self.showViewController(vc as UIViewController, sender: vc)
    
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