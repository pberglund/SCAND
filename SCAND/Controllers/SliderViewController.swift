//
//  DashBoardController.swift
//  SingleView
//
//  Created by Sage Path on 11/5/14.
//  Copyright (c) 2014 Sage Path. All rights reserved.
//

import UIKit

@IBDesignable class SliderViewController : BaseViewController {
    
    @IBInspectable var videName:String!
    @IBInspectable var videoExtension: String!
    @IBInspectable var leftSegueIdentifier: String!
    @IBInspectable var rightSequeIdentifier: String!

    @IBOutlet weak var label: UILabel!
    let transitionDistance:CGFloat = 300
    var lastDirection:Direction = Direction.None
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var expandCollapseButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sliderView.frame = self.view.frame;        
    }
    
    @IBAction func swipedUp(sender: AnyObject) {
        
        println("swiped up...")
        slide(Direction.Down);
    }
    @IBAction func swipedDown(sender: AnyObject) {
        println("swiped down...")
        slide(Direction.Up);
    }
    
    @IBAction func swipedRight(sender: AnyObject) {
        println("swiped right...")
        slide(Direction.Left);
    }
    
    @IBAction func swipedLeft(sender: AnyObject) {
        println("swiped left...")
        slide(Direction.Right);
    }
    //override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
    //    return false;
    //}
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == leftSegueIdentifier){
            println("swiped left...")
            slide(Direction.Right);
        }
        
        if(segue.identifier == rightSequeIdentifier){
            println("swiped right...")
            slide(Direction.Left);
        }
    }*/
    
    func slide(direction: Direction){
        
        // If we havent slide, and they want to slide up, return
        if(lastDirection == Direction.None && direction == Direction.Down){
            return;
        }
        
        //If they are trying to swipe the same way as the last time, return
        if(lastDirection == direction){
            return;
        }
        
        let leftOrRight = (direction == Direction.Left || direction == Direction.Right)

        if(lastDirection == Direction.Up && leftOrRight){
            
            println("Sliding up before transistion \(direction.hashValue)")
            
            
            slideIt(Direction.Down, { self.segueWithDirection(direction)})
            
            return;
        }
        
        if(leftOrRight){
            self.segueWithDirection(direction)
            return
        }


        slideIt(direction, nil)
        lastDirection = direction;
        
    }
    
    
    
    func segueWithDirection(direction: Direction) -> Void{
        
        var pageName = self.pageIdentifier;
        if(pageName == nil){
            pageName = "";
        }
        
        switch direction {
        case Direction.Left:
            //self.performSegueWithIdentifier("Slide To Main", sender: self)
            //let vc:ViewController = ViewController()
             //let vc : AnyObject! = self.storyboard.instantiateViewControllerWithIdentifier("1StartPage")
             //self.showViewController(vc as UIViewController, sender: vc)
            self.transitionToViewControllerBySegueIdentifier(leftSegueIdentifier, originPage: pageName)
            
        case Direction.Right:
            self.transitionToViewControllerBySegueIdentifier(rightSequeIdentifier, originPage: pageName)

        default:
            println("Error finding a direction, segueWithDirection: returning")
        }
        
        return
    }
    
    func slideIt(direction: Direction, completion: (() -> Void)!){
        //println("In slideIt")
        
        let currFrame = sliderView.frame
        
        let newX:CGFloat = currFrame.origin.x
        var newY:CGFloat = currFrame.origin.y
        
        
        switch direction {
		case Direction.Up:
		    newY -= transitionDistance
        case Direction.Down:
            newY += transitionDistance
        default:
            println("Error finding a direction, slideIt: returning")
            return;
            
        }
        
        let newFrame:CGRect = CGRectMake(newX, newY, currFrame.width, currFrame.height);
        
        UIView.animateWithDuration(2.0, animations: {
            
            self.sliderView.frame = newFrame
            //println("sliding...")
            
            }, completion: {
            (value: Bool) in
            
                //println("Done sliding")
                if((completion) != nil){
                    completion()
                }
                
                        })
        //println("Leaving slideIt");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}