//
//  SetupGameViewController.swift
//  Monopoly Banker
//
//  Created by Dmytro Bogatov on 1/19/15.
//  Copyright (c) 2015 Dmytro Bogatov. All rights reserved.
//

import UIKit

class SetupGameViewController: UIViewController {

	var currency : String = "$"
	
	@IBOutlet weak var player1: UITextField!
	@IBOutlet weak var player2: UITextField!
	@IBOutlet weak var player3: UITextField!
	@IBOutlet weak var player4: UITextField!
	
	@IBAction func currencyPressed(sender: UIButton) {
		currency = sender.titleLabel!.text!
	}
	
	@IBAction func playPressed(sender: UIButton) {
		if noDuplicateNames(player1.text, player2.text, player3.text, player4.text) {
			DataModel.sharedInstance.startNewGame(currency, names: [player1.text, player2.text, player3.text, player4.text])
			self.dismissViewControllerAnimated(true, completion: nil)
		}
	}
	
	func noDuplicateNames(names: String...) -> Bool {
		
		
		/*
		if names[0] == names [1] || names [0] == [names[2] || names[0] == names[3] {
			return false
		} else if names[1] == names [2] || names [1] == [names[3] && names[1] != "" {
			return false
		} else if names[3] == names [4] && names[3] != "" {
			return false
		} else {
			return true
		}*/
		return true
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
