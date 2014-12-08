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
    
    var transitionManager = TransitionManager()
    
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
    
    deinit {
        var origin = pageIdentifier
        if(pageIdentifier == nil){
            origin = self.description;
        }
        //self.transitionManager = nil;
        println("DeInit: BaseViewController: \(origin)")
        //super.deinit;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //println("Presenting: \(self.presentingViewController)")
        
        //println("Presented: \(self.presentedViewController)")
        
        println("Page identifier: \(pageIdentifier)")
    }
    
    func setBackGroundImage(){
        if(backgroundImageFileName == nil){
            return
        }
        
        unowned var weakSelf = self;
        
        var image = weakSelf.getImageFromBundle(weakSelf.backgroundImageFileName)
        
        //var resized = RBResizeImage(image!, targetSize: weakSelf.view.bounds.size)
        weakSelf.view.backgroundColor = UIColor(patternImage: image!)
        
        image = nil
        //resized = nil
        
    }
    
    func addMenuButton(){
        
         weak var weakSelf = self;
        
        weak var button :UIButton?  = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        button!.frame = CGRectMake(960, 25, 40, 35)
        button!.addTarget(weakSelf!, action: "openMenu:", forControlEvents:.TouchUpInside)
        weakSelf!.view.addSubview(button!)
        button = nil

    }
    
    func openMenu(sender:UIButton!)
    {
        //println("Menu Button tapped")
        //println("Going to menu from \(pageIdentifier)")
        if(pageIdentifier == nil || pageIdentifier == "")
        {
            //println("Pageidentifier was null, not going to menu")
            return
        }
        
        var vc = getViewControllerFromstoryboardID("MenuPage")
        //vc.returnStoryBoardId = pageIdentifier;
        //vc.transManager = transitionManager;
        
         self.showController(vc);
        
    }    
    
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        // this func left empty intentionally, the transition manager 
        // handles swiping back to the origin view controller
    }
    
    
    func transitionToViewControllerBySegueIdentifier(segueIdentifier:String = "", originPage:String = ""){
        var origin = originPage;
        
        if(origin == ""){
            if(pageIdentifier == nil){
                origin = self.description;
            }
            else{
                origin = pageIdentifier
            }
        }
        
        if(segueIdentifier == ""){
            println("SegueIdentifier was empty, origin: \(origin)")
            return
        }
        
        //weak var weakSelf = self;
        
        self.performSegueWithIdentifier(segueIdentifier, sender: self)

        println("Self: \(origin), Transition: \(segueIdentifier)")

    }
    
    func getViewControllerFromstoryboardID(storyBoardId:String) -> UIViewController{
        //weak var weakSelf = self;
        
        var vc : UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier(storyBoardId) as UIViewController
        vc.transitioningDelegate = self.transitionManager
        return vc;
    }
    
    func showController(vc:UIViewController) -> Void{
        
        self.showViewController(vc, sender: vc)
    }
    
    func transitionToViewControllerByStoryboardId(storyBoardId:String){
        
        var vc = getViewControllerFromstoryboardID(storyBoardId);
        showController(vc);
    }
    
    func getImageFromBundle(imageNameWithExtension:String) -> UIImage?{
        //let bundle = NSBundle.mainBundle()
        //println(bundle)
        //println("Backgroundimage file name: \(imageNameWithExtension)")
        //let pathhtml:String = bundle.pathForResource(imageNameWithExtension, ofType: nil)!
        //println("pathhtml: \(pathhtml)")
        //let minusExtension = imageNameWithExtension.substringToIndex(advance(imageNameWithExtension.startIndex, countElements(imageNameWithExtension) - 4))

        var image = UIImage(named: imageNameWithExtension)
        
        return image!;
    }
    
    /*func RBResizeImage(image: UIImage?, targetSize: CGSize) -> UIImage? {
        weak var newImage :UIImage?
        
        let size = image!.size
        
        let widthRatio  = targetSize.width  / image!.size.width
        let heightRatio = targetSize.height / image!.size.height
        
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
        image!.drawInRect(rect)
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
               
        return newImage
        
    }*/

}