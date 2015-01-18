//
//  PageContentViewController.swift
//  Monopoly Banker
//
//  Created by Dmytro Bogatov on 1/17/15.
//  Copyright (c) 2015 Dmytro Bogatov. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var pageIndex : Int = 0;
    var titleText : String = "";
    var imageFileName : String = "";
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.backgroundImageView.image = UIImage(named: self.imageFileName);
        self.titleLabel.text = self.titleText;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
        
}
