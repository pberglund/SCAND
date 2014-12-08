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
        /*
println("Dashboard - catperfrom: \(self.categoryPerformanceSegueIdentifier)")
        println("Dashboard - assortmentPortfolioSegueIdentifier: \(self.assortmentPortfolioSegueIdentifier)")
        println("Dashboard - pricingAnalysisSegueIdentifier: \(self.pricingAnalysisSegueIdentifier)")
        println("Dashboard - storePerformanceSegueIdentifier: \(self.storePerformanceSegueIdentifier)")
        
        println("Dashboard - shopperMarketingSegueIdentifier: \(self.shopperMarketingSegueIdentifier)")
*/
    }
    
    deinit{
        println("Deinit - dashboardcontroller")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func categoryPerformanceButtonTouchUpInside(sender: AnyObject) {
        //weak var weakSelf = self;
        self.transitionToViewControllerByStoryboardId("Category Performance Start")
    }
    
    @IBAction func assortmentPortfolioButtonTouchUpInside(sender: AnyObject) {
        //weak var weakSelf = self;
        self.transitionToViewControllerByStoryboardId(assortmentPortfolioSegueIdentifier)
    }
    
    @IBAction func pricingAnalysisButtonTouchUpInside(sender: AnyObject) {
        //weak var weakSelf = self;
        self.transitionToViewControllerByStoryboardId(pricingAnalysisSegueIdentifier)
    }
    @IBAction func shopperMarketingButtonTouchUpInside(sender: AnyObject) {
        //weak var weakSelf = self;
        self.transitionToViewControllerByStoryboardId(shopperMarketingSegueIdentifier)
    }
    
    @IBAction func storePerformanceButtonTouchUpInside(sender: AnyObject) {
        //weak var weakSelf = self;
        self.transitionToViewControllerByStoryboardId(storePerformanceSegueIdentifier)
    }
    
}


