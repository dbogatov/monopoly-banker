//
//  ViewController.swift
//  Monopoly Banker
//
//  Created by Dmytro Bogatov on 1/17/15.
//  Copyright (c) 2015 Dmytro Bogatov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		
    }

	override func viewDidAppear(animated: Bool) {
		if DataModel.sharedInstance.isFirstLaunch {
			performSegueWithIdentifier("tutorialSegue", sender: nil)
		}
		DataModel.sharedInstance.writeFistTimeLaunch()
		
		if DataModel.sharedInstance.isGameSet {
			performSegueWithIdentifier("newGameSegue", sender: nil)
		}
		
		DataModel.sharedInstance.sortGames()
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

