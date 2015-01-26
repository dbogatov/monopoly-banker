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
	var currrencyButton : UIButton?
	
	@IBOutlet var paidCurrencies: [UIButton]!
	
	@IBOutlet weak var player1: UITextField!
	@IBOutlet weak var player2: UITextField!
	@IBOutlet weak var player3: UITextField!
	@IBOutlet weak var player4: UITextField!
	
	@IBAction func currencyPressed(sender: UIButton) {
		currrencyButton?.setColor(UIColor.orangeColor(), state: UIControlState.Normal)
		currency = sender.titleLabel!.text!
		currrencyButton = sender
		currrencyButton?.setColor(UIColor.greenColor(), state: UIControlState.Normal)
	}
	
	@IBAction func playPressed(sender: UIButton) {
		if noDuplicateNames(player1.text, player2.text, player3.text, player4.text) == true {
			DataModel.sharedInstance.startNewGame(currency, names: [player1.text, player2.text, player3.text, player4.text])
			self.dismissViewControllerAnimated(true, completion: nil)
		} else {
			var alert = UIAlertController(title: "Invalid input", message: "You cannot have identical names or leave all fields empty", preferredStyle: UIAlertControllerStyle.Alert)
			alert.addAction(UIAlertAction(title: "Okey", style: UIAlertActionStyle.Default, handler: nil))
			self.presentViewController(alert, animated: true, completion: nil)
		}
	}
	
	@IBAction func backButtonPressed(sender: UIButton) {
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
	func noDuplicateNames(names: String...) -> Bool {
		
		var set = NSMutableSet()
		var objNum = 0
		
		for name in names {
			if !name.isEmpty {
				set.addObject(name.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
				objNum++
			}
		}
		
		return set.count == objNum && objNum != 0;
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		for button in paidCurrencies {
			button.enabled = InAppPurchasesController.sharedInstance.isPurchased()
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
