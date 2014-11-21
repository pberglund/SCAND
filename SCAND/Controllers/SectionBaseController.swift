//
//  SectionLandingController.swift
//  SCAND
//
//  Created by Sagepath on 11/20/14.
//  Copyright (c) 2014 Sagepath. All rights reserved.
//


import UIKit
import MediaPlayer

@IBDesignable class SectionBaseController: BaseScanDController {
    
    //@IBInspectable var leftView: String!
    
    @IBInspectable var rightView: String!
    @IBInspectable var videoName: String!
    @IBInspectable var videoExtension: String!
    let transitionDistance:CGFloat = 768
    let animationDuration = 2.0
    var lastDirection:Direction = Direction.None
    
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var expandCollapseButton: UIButton!
    
    
    var downArrowView: UIView!
    var upArrowView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showHideArrows(showArrow:UIView, hideArrow:UIView){
        UIView.animateWithDuration(0.75, animations: {
            hideArrow.alpha = 1.0
            showArrow.alpha = 0.0
        })
    }
    
    func arrowAnimationUp(){
        showHideArrows(downArrowView, hideArrow: upArrowView)
    }
    
    func arrowAnimationDown(){
        showHideArrows(upArrowView, hideArrow: downArrowView)
    }
    
    func goRight(){
        self.transitionToViewControllerByStoryboardId(rightView)
    }
    
    func goLeft(){
        self.transitionToViewControllerBySegueIdentifier("unwindSegue", originPage: self.pageIdentifier)
    }
    
    @IBAction func rightArrowButton(sender: AnyObject) {
        println("Clicked right arrow, going to: \(rightView)")
        goRight()
    }
    
    var moviePlayer:MPMoviePlayerController!
    
    @IBAction func playArrowButton(sender: AnyObject) {
        println("Clicked Play")
        playVideo()
    }
    
    func playVideo() -> Void{
        
        if(videoName == "" || videoExtension == ""){
            return
        }
        
        let bundle = NSBundle.mainBundle()
        let pathhtml = bundle.pathForResource(videoName, ofType: videoExtension)
        var url:NSURL = NSURL(fileURLWithPath: pathhtml!)!
        
        
        moviePlayer = MPMoviePlayerController(contentURL: url)
        
        moviePlayer.view.frame = self.view.bounds
        
        moviePlayer.fullscreen = true
        
        moviePlayer.shouldAutoplay = true
        
        //moviePlayer.movieSourceType = MPMovieSourceType.Streaming
        
        //moviePlayer.scalingMode = MPMovieScalingMode.AspectFill
        
        moviePlayer.controlStyle = MPMovieControlStyle.Fullscreen;

       
        self.view.addSubview(moviePlayer.view)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "moviePlayerOver:", name: MPMoviePlayerPlaybackDidFinishNotification, object: moviePlayer)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "moviePlayerExitingFullScreen:", name: MPMoviePlayerWillExitFullscreenNotification, object: moviePlayer)
        
        
        
        self.view.bringSubviewToFront(moviePlayer.view)
        
        moviePlayer.play()
        
        println("Playing Movie");
    }
    
    @objc
    func moviePlayerExitingFullScreen(notification: NSNotification){
        println("In moviePlayerExitingFullScreen");
        
        doExitMoviePlayer()
    }

    func doExitMoviePlayer() -> Void{
        
        moviePlayer.setFullscreen(false, animated: true)
        moviePlayer.view.removeFromSuperview()
    }
    
    @objc
    func moviePlayerOver(notification: NSNotification){
        println("In moviePlayerDidFinishPlaying");

        //let userInfo : [NSObject : AnyObject]? = notification.userInfo
        
        
        //var playbackDidFinish : Int = userInfo![MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] as Int
        
        
        doExitMoviePlayer()
        
        /*if(playbackDidFinish == MPMovieFinishReason.UserExited.rawValue || playbackDidFinish == MPMovieFinishReason.PlaybackEnded.rawValue)
        {
            moviePlayer.view.removeFromSuperview()
        }*/
        
        
        
        
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
            //self.transitionToViewControllerBySegueIdentifier(leftSegueIdentifier, originPage: pageName)
            goLeft();
        case Direction.Right:
            // self.transitionToViewControllerBySegueIdentifier(rightSequeIdentifier, originPage: pageName)
            goRight();
            
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
            arrowAnimationUp()
        case Direction.Down:
            newY += transitionDistance
            arrowAnimationDown()
        default:
            println("Error finding a direction, slideIt: returning")
            return;
            
        }
        
        let newFrame:CGRect = CGRectMake(newX, newY, currFrame.width, currFrame.height);
        
        UIView.animateWithDuration(animationDuration, animations: {
            
            self.sliderView.frame = newFrame
            //println("sliding...")
            
            }, completion: {
                (value: Bool) in
                
                //println("Done sliding")
                if((completion) != nil){
                    completion()
                }
                
        })
        println("Leaving slideIt");
    }
    
}
