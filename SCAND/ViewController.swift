//
//  ViewController.swift
//  SingleView
//
//  Created by Sage Path on 11/5/14.
//  Copyright (c) 2014 Sage Path. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: BaseViewController {

    var moviePlayer:MPMoviePlayerController!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "start.jpg")
        let resized = RBResizeImage(image!, targetSize: self.view.bounds.size)
        
        self.view.backgroundColor = UIColor(patternImage: resized)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


   
    
}

