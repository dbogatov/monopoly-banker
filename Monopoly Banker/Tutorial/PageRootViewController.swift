//
//  PageRootViewController.swift
//  Monopoly Banker
//
//  Created by Dmytro Bogatov on 1/17/15.
//  Copyright (c) 2015 Dmytro Bogatov. All rights reserved.
//

import UIKit

class PageRootViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    @IBOutlet weak var infoLabel: UILabel!
    
    @IBAction func startWalkthrough() {
        print("startWalkthrough");
        
        var startingViewController : PageContentViewController  = self.viewControllerAtIndex(0)!;
        var viewControllers : NSArray = [startingViewController];
        self.pageViewController?.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Reverse, animated: true, completion: nil);
        infoLabel.text = pageTitles.firstObject as? String
    }
    
    @IBAction func exitTutorial() {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    
    var pageViewController : UIPageViewController?
    var pageTitles : NSArray = [];
    var pageImages : NSArray = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageTitles =
            [
                "Welcome to Banker! This tool is designed to help you keep track of players' budgets easily.",
                "You may setup a new game by telling us players' names and choosing a currency.",
                "After game is setup, you may start depositing, charging and trasferring money among players.",
                "Don't forget to choose a card first! 😉",
                "All games are saved automatically. You may continue playing at any time.",
                "If you want to unlock even more functionallity, provide feedback or get acquainted with the developer, welcome to Extras!"
        ];
        
        pageImages = ["InitView.PNG", "Setup.PNG", "PlayCharge.PNG", "PlayTransfer.PNG", "Load.PNG", "Extras.PNG"];
        
        infoLabel.text = pageTitles.firstObject as? String
        
        // Create page view controller
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController")! as? UIPageViewController;
        self.pageViewController!.dataSource = self;
        self.pageViewController!.delegate = self;
        
        var startingViewController : PageContentViewController  = self.viewControllerAtIndex(0)!;
        var viewControllers : NSArray = [startingViewController];
        self.pageViewController!.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil);
        
        // Change the size of page view controller
        self.pageViewController!.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 100)
		
        self.addChildViewController(self.pageViewController!);
        self.view.addSubview(self.pageViewController!.view);
        self.pageViewController!.didMoveToParentViewController(self);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as PageContentViewController).pageIndex;
        
        if index == 0 {
            return nil;
        }
        index--;
        
        return self.viewControllerAtIndex(index);
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as PageContentViewController).pageIndex;
        
        if index == NSNotFound {
            return nil;
        }
        index++;
        
        if index == pageTitles.count {
            return nil;
        }
        
        
        return self.viewControllerAtIndex(index);
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageTitles.count;
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0;
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject], transitionCompleted completed: Bool) {
        var page : PageContentViewController = pageViewController.viewControllers.first as PageContentViewController
        infoLabel!.text = page.titleText
    }
    
    // MARK: Helper methods
    
    func viewControllerAtIndex(index: Int) -> PageContentViewController? {
        
        if pageTitles.count == 0 || index >= pageTitles.count {
            return nil;
        }
        
        var pageContentViewController : PageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController")! as PageContentViewController;
        pageContentViewController.imageFileName = self.pageImages[index] as String;
        pageContentViewController.titleText = self.pageTitles[index] as String;
        pageContentViewController.pageIndex = index;
        
        return pageContentViewController;
    }

}
