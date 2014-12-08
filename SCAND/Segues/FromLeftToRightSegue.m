//
//  CustomSegue.m
//  SingleView
//
//  Created by Sage Path on 11/5/14.
//  Copyright (c) 2014 Sage Path. All rights reserved.
//

#import "FromLeftToRightSegue.h"
#import "QuartzCore/QuartzCore.h"

@implementation FromLeftToRightSegue


- (void)perform {
    UIViewController* source = (UIViewController *)self.sourceViewController;
    UIViewController* destination = (UIViewController *)self.destinationViewController;
    
    CGRect sourceFrame = source.view.frame;
    sourceFrame.origin.x = sourceFrame.size.width;
    
    CGRect destFrame = destination.view.frame;
    destFrame.origin.x = -destination.view.frame.size.width;
    destination.view.frame = destFrame;
    
    destFrame.origin.x = 0;
    
    [source.view.superview addSubview:destination.view];
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         source.view.frame = sourceFrame;
                         destination.view.frame = destFrame;
                     }
                     completion:^(BOOL finished) {
                         UIWindow *window = source.view.window;
                         [window setRootViewController:destination];
                         //[ dismissViewControllerAnimated:NO ];
                         
                     }];
}


/*

-(void)perform {
    
    UIView *sv = ((UIViewController *)self.sourceViewController).view;
    UIView *dv = ((UIViewController *)self.destinationViewController).view;
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    dv.center = CGPointMake(sv.center.x + sv.frame.size.width,
                            dv.center.y);
    [window insertSubview:dv aboveSubview:sv];
    
    [UIView animateWithDuration:0.4
                     animations:^{
                         dv.center = CGPointMake(dv.center.x,sv.center.y
                                                 );
                         sv.center = CGPointMake(
                                                 0 - dv.center.x,
                                                 sv.center.y);
                     }
                     completion:^(BOOL finished){
                         [[self sourceViewController] presentViewController:
                          [self destinationViewController] animated:NO completion:nil];
                     }];
}

*/
@end

/*
 
 -(void)perform {
 
 UIViewController *sourceViewController = (UIViewController*)self.sourceViewController;;
 UIViewController *destinationController = (UIViewController*)self.destinationViewController;
 
 CATransition* transition = [CATransition animation];
 transition.duration = .25;
 transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
 transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
 transition.subtype = kCATransitionFromLeft; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
 
 
 
 [sourceViewController.navigationController.view.layer addAnimation:transition
 forKey:kCATransition];
 
 [sourceViewController.navigationController pushViewController:destinationController animated:NO];
 
 }
 @end
 
 */


/*
 - (void)perform {
 UIViewController *sourceViewController = self.sourceViewController;
 UIViewController *destinationViewController = self.destinationViewController;
 
 // Add the destination view as a subview, temporarily
 [sourceViewController.view addSubview:destinationViewController.view];
 
 // Transformation start scale
 destinationViewController.view.transform = CGAffineTransformMakeScale(0.05, 0.05);
 
 // Store original centre point of the destination view
 CGPoint originalCenter = destinationViewController.view.center;
 // Set center to start point of the button
 destinationViewController.view.center = self.originatingPoint;
 
 [UIView animateWithDuration:0.5
 delay:0.0
 options:UIViewAnimationOptionTransitionFlipFromRight
 animations:^{
 // Grow!
 destinationViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
 destinationViewController.view.center = originalCenter;
 }
 completion:^(BOOL finished){
 [destinationViewController.view removeFromSuperview]; // remove from temp super view
 [sourceViewController presentViewController:destinationViewController animated:NO completion:NULL]; // present VC
 }];
 }
 
 @end
 
 */
