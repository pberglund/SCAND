//
//  DashBoardController.swift
//  SCAND
//
//  Created by Sagepath on 11/18/14.
//  Copyright (c) 2014 Sagepath. All rights reserved.
//

import UIKit
import MediaPlayer

@IBDesignable class DashboardController: BaseScanDController {
    
    @IBInspectable var categoryPerformanceSegueIdentifier: String!
    @IBInspectable var assortmentPortfolioSegueIdentifier: String!
    @IBInspectable var pricingAnalysisSegueIdentifier: String!
    @IBInspectable var storePerformanceSegueIdentifier: String!
    @IBInspectable var shopperMarketingSegueIdentifier: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func categoryPerformanceButtonTouchUpInside(sender: AnyObject) {
        self.transitionToViewControllerByStoryboardId(categoryPerformanceSegueIdentifier)
    }
    
    @IBAction func assortmentPortfolioButtonTouchUpInside(sender: AnyObject) {
        self.transitionToViewControllerByStoryboardId(assortmentPortfolioSegueIdentifier)
    }
    
    @IBAction func pricingAnalysisButtonTouchUpInside(sender: AnyObject) {
        self.transitionToViewControllerByStoryboardId(pricingAnalysisSegueIdentifier)
    }
    @IBAction func shopperMarketingButtonTouchUpInside(sender: AnyObject) {
        self.transitionToViewControllerByStoryboardId(shopperMarketingSegueIdentifier)
    }
    
    @IBAction func storePerformanceButtonTouchUpInside(sender: AnyObject) {
                self.transitionToViewControllerByStoryboardId(storePerformanceSegueIdentifier)
    }
    
}


