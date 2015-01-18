//
//  PageRootViewController.swift
//  Monopoly Banker
//
//  Created by Dmytro Bogatov on 1/17/15.
//  Copyright (c) 2015 Dmytro Bogatov. All rights reserved.
//

import UIKit

class PageRootViewController: UIViewController, UIPageViewControllerDataSource {

    
    @IBAction func startWalkthrough() {
        print("startWalkthrough");
    }
    
    var pageViewController : UIPageViewController?
    var pageTitles : NSArray = [];
    var pageImages : NSArray = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageTitles = ["Over 200 Tips and Tricks", "Discover Hidden Features", "Bookmark Favorite Tip", "Free Regular Update"];
        pageImages = ["page1.png", "page2.png", "page3.png", "page4.png"];
        
        // Create page view controller
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController")! as? UIPageViewController;
        self.pageViewController!.dataSource = self;
        
        var startingViewController : PageContentViewController  = self.viewControllerAtIndex(0)!;
        var viewControllers : NSArray = [startingViewController];
        self.pageViewController!.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil);
        
        // Change the size of page view controller
        self.pageViewController!.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
        
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
