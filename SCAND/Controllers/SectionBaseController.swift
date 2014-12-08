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
    
    @IBInspectable var rightSegueIdentifier: String!
    @IBInspectable var leftSegueIdentifier: String!
    @IBInspectable var videoName: String!
    @IBInspectable var videoExtension: String!
    let transitionDistance:CGFloat = 768
    let animationDuration = 2.0
    var lastDirection:Direction = Direction.None
    
    @IBOutlet weak var sliderView: UIView!
    var downArrowView: UIView!
    var upArrowView: UIView!
    
    var moviePlayer:MPMoviePlayerController!
    
    deinit {
       
        println("DeInit: section base -  \(self.pageIdentifier)")
        /*self.sliderView.removeFromSuperview();
        self.sliderView = nil
        
        self.downArrowView.removeFromSuperview()
        self.downArrowView = nil
        
        self.upArrowView.removeFromSuperview()
        self.upArrowView = nil

        self.moviePlayer = nil
*/
        ClearSpace()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        ClearSpace()
    }
    
    
    func ClearSpace(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func showHideArrows(showArrow:UIView, hideArrow:UIView){
        UIView.animateWithDuration(0.75, animations: {
            hideArrow.alpha = 1.0
            showArrow.alpha = 0.0
        })
    }
    
    func arrowAnimationUp(){
        weak var weakDown = downArrowView;
        weak var weakUp = upArrowView;
        showHideArrows(weakDown!, hideArrow: weakUp!)
    }
    
    func arrowAnimationDown(){
        weak var weakDown = downArrowView;
        weak var weakUp = upArrowView;
        showHideArrows(weakUp!, hideArrow: weakDown!)
    }
    
    func goRight(){
        transistionBySegue(leftSegueIdentifier)
    }
    
    func transistionBySegue(segueIdentifier:String) -> Void{
        weak var weakSelf = self;
        weakSelf!.transitionToViewControllerBySegueIdentifier(segueIdentifier: segueIdentifier, originPage: weakSelf!.pageIdentifier)
    }
    
    func goLeft(){
        transistionBySegue(rightSegueIdentifier)
    }
    
    @IBAction func leftArrowButton(sender: AnyObject) {
        goLeft()
    }
    @IBAction func rightArrowButton(sender: AnyObject) {
        goRight()
    }
    
    @IBAction func playArrowButton(sender: AnyObject) {
        //println("Clicked Play")
        playVideo()
    }
    
    func playVideo() -> Void{
        
        if(videoName == nil || videoName == "" || videoExtension == nil || videoExtension == ""){
            return
        }
        
        let bundle = NSBundle.mainBundle()
        let pathhtml = bundle.pathForResource(videoName, ofType: videoExtension)
        var url:NSURL = NSURL(fileURLWithPath: pathhtml!)!
        
        moviePlayer = MPMoviePlayerController(contentURL: url)
        
        weak var weakSelf = self;
        
        
        moviePlayer.view.frame = weakSelf!.view.bounds
        
        moviePlayer.fullscreen = true
        
        moviePlayer.shouldAutoplay = true
        
        //moviePlayer.movieSourceType = MPMovieSourceType.Streaming
        
        //moviePlayer.scalingMode = MPMovieScalingMode.AspectFill
        
        moviePlayer.controlStyle = MPMovieControlStyle.Fullscreen;
       
        weakSelf!.view.addSubview(moviePlayer.view)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "moviePlayerOver:", name: MPMoviePlayerPlaybackDidFinishNotification, object: moviePlayer)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "moviePlayerExitingFullScreen:", name: MPMoviePlayerWillExitFullscreenNotification, object: moviePlayer)
        
        weakSelf!.view.bringSubviewToFront(moviePlayer.view)
        
        moviePlayer.play()
        
        //println("Playing Movie");
    }
    
    @objc
    func moviePlayerExitingFullScreen(notification: NSNotification){
        //println("In moviePlayerExitingFullScreen");
        
        doExitMoviePlayer()
    }

    func doExitMoviePlayer() -> Void{
        
        if( moviePlayer == nil){
            return;
        }
        else{
        
        if(moviePlayer.playbackState == MPMoviePlaybackState.Playing){
            moviePlayer.stop();
        }
        
        moviePlayer.setFullscreen(false, animated: true)
        moviePlayer.view.removeFromSuperview()
        }
    }
    
    @objc
    func moviePlayerOver(notification: NSNotification){
        //println("In moviePlayerDidFinishPlaying");
        doExitMoviePlayer()
    }
    
    @IBAction func swipedUp(sender: AnyObject) {
        
        //println("swiped up...")
        slide(Direction.Up);
    }
    
    @IBAction func swipedDown(sender: AnyObject) {
        //println("swiped down...")
        slide(Direction.Down);
    }
    
    @IBAction func swipedRight(sender: AnyObject) {
        //println("swiped right...")
        slide(Direction.Left);
    }
    
    @IBAction func swipedLeft(sender: AnyObject) {
        //println("swiped left...")
        slide(Direction.Right);
    }
    
    func slide(direction: Direction){
        
        let moviePlaying = moviePlayer != nil && moviePlayer.playbackState == MPMoviePlaybackState.Playing;
        
        weak var weakSelf = self;
        
        // If we havent slid, and they want to slide up, return
        if(lastDirection == Direction.None && direction == Direction.Down){
            return;
        }
        
        //If they are trying to swipe the same way as the last time, return
        if(lastDirection == direction){
            return;
        }
        
        let leftOrRight = (direction == Direction.Left || direction == Direction.Right)
        
        if(leftOrRight){
            
            doExitMoviePlayer()
            
            if(lastDirection == Direction.Up ){
            
            //println("Sliding up before transistion \(direction.hashValue)")
            
            
            slideIt(Direction.Down, { weakSelf!.segueWithDirection(direction)})
            
            }
            else{
                weakSelf!.segueWithDirection(direction)
            }
            
            return;
        }
                
        if(moviePlaying){
            return;
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
            goLeft();
        case Direction.Right:
            goRight();
            
        default:
            println("Error finding a direction, segueWithDirection: returning")
        }
        
        return
    }
    
    func slideIt(direction: Direction, completion: (() -> Void)!){
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
        
        weak var weakSelf = self;
        
        var newFrame:CGRect? = CGRectMake(newX, newY, currFrame.width, currFrame.height) as CGRect?;
        
        UIView.animateWithDuration(animationDuration, animations: {
            
            weakSelf!.sliderView.frame = newFrame!
            
            }, completion: {
                (value: Bool) in
                
                if((completion) != nil){
                    completion()
                }
                
        })

        newFrame = nil
        //println("Leaving slideIt");
    }
    
}
