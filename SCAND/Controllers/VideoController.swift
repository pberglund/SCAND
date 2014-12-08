//
//  DashBoardController.swift
//  SingleView
//
//  Created by Sage Path on 11/5/14.
//  Copyright (c) 2014 Sage Path. All rights reserved.
//

import UIKit
import MediaPlayer

@IBDesignable class VideoController : BaseScanDController {
    
    var moviePlayer:MPMoviePlayerController!
    @IBInspectable var segueAfterVideo: String!
    @IBInspectable var videoName: String!
    @IBInspectable var videoExtension: String!
    
    var deinitCalled = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpAndPlayMovie(videoName,fileExtension: videoExtension )
    }
    
    deinit{
        deinitCalled = true;
        println("Deinit: VideoController: \(self.pageIdentifier)")
        stopMovieIfPlaying()
        
        self.moviePlayer = nil
    }
    
    func setUpAndPlayMovie(fileName:String, fileExtension:String){
        
        let bundle = NSBundle.mainBundle()
        let pathhtml = bundle.pathForResource(fileName, ofType: fileExtension)
        var url:NSURL = NSURL(fileURLWithPath: pathhtml!)!
        
        
        moviePlayer = MPMoviePlayerController(contentURL: url)!
        
        moviePlayer!.view.frame = self.view.bounds
        
        moviePlayer!.fullscreen = true
        
        moviePlayer!.shouldAutoplay = true
        
        //moviePlayer.movieSourceType = MPMovieSourceType.Streaming
        
        //moviePlayer.scalingMode = MPMovieScalingMode.AspectFill
        
        moviePlayer!.controlStyle = MPMovieControlStyle.Fullscreen;
        
        self.view.addSubview(moviePlayer!.view)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "moviePlayerOver:", name: MPMoviePlayerPlaybackDidFinishNotification, object: moviePlayer!)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "moviePlayerOver:", name: MPMoviePlayerWillExitFullscreenNotification, object: moviePlayer!)
        
        self.view.bringSubviewToFront(moviePlayer.view!)
        
        moviePlayer!.play()
        
        //println("Playing Movie");

    }
    
    @IBAction func swipedLeft(sender: AnyObject) {
        transitionToMain()
    }
    
    func transitionToMain(){
        if(self.moviePlayer != nil && !deinitCalled){
            stopMovieIfPlaying()
            
            self.transitionToViewControllerBySegueIdentifier(segueIdentifier: segueAfterVideo )
            
            //println("Show initial controller")
        }
    }
    
    @objc
    func moviePlayerExitingFullScreen(notification: NSNotification){
       // println("In moviePlayerExitingFullScreen");
        transitionToMain()
    }
    
    @objc
    func moviePlayerOver(notification: NSNotification){
    //Action take on Notification
        //println("In moviePlayerDidFinishPlaying");
        //self.performSegueWithIdentifier("Custom from 1 to main", sender: self)
        transitionToMain()

    }
    
    func stopMovieIfPlaying() -> Void{
        
        if(self.moviePlayer != nil){
            if(self.moviePlayer.playbackState == MPMoviePlaybackState.Playing){
                self.moviePlayer.stop();
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.moviePlayer = nil
    }
}