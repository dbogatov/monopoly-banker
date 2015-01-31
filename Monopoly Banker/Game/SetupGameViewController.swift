//
//  SetupGameViewController.swift
//  Monopoly Banker
//
//  Created by Dmytro Bogatov on 1/19/15.
//  Copyright (c) 2015 Dmytro Bogatov. All rights reserved.
//

import UIKit

class SetupGameViewController: UIViewController, UITextFieldDelegate {

	var currency : String = "$"
	var currrencyButton : UIButton?
	
	@IBOutlet weak var loadingImage: UIImageView!
	@IBOutlet weak var loadingLabel: UILabel!
	
	@IBOutlet var paidCurrencies: [UIButton]!
	
	@IBOutlet weak var player1: UITextField!
	@IBOutlet weak var player2: UITextField!
	@IBOutlet weak var player3: UITextField!
	@IBOutlet weak var player4: UITextField!
	
	@IBAction func currencyPressed(sender: UIButton) {
        currrencyButton?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
		currency = sender.titleLabel!.text!
		currrencyButton = sender
        currrencyButton?.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
	}
	
	@IBAction func playPressed(sender: UIButton) {
		if noDuplicateNames(player1.text, player2.text, player3.text, player4.text) == true {
			DataModel.sharedInstance.startNewGame(currency, names: [player1.text, player2.text, player3.text, player4.text])
			self.dismissViewControllerAnimated(true, completion: nil)
		} else {
			var alert = UIAlertController(title: "Invalid input", message: "You cannot have identical names, leave all fields empty or play alone", preferredStyle: UIAlertControllerStyle.Alert)
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
		
		return set.count == objNum && objNum > 1;
	}
	
	// MARK: - UITextField delegate methods
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		if textField === player1 {
			textField.resignFirstResponder()
			player2.becomeFirstResponder()
		} else if textField === player2 {
			textField.resignFirstResponder()
			player3.becomeFirstResponder()
		} else if textField == player3 {
			textField.resignFirstResponder()
			player4.becomeFirstResponder()
		} else if textField === player4 {
			textField.resignFirstResponder()
		}
		
		return true
	}
	
	func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
		if range.length + range.location > countElements(textField.text) {
			return false;
		}
		
		let newLength : Int = countElements(textField.text) + countElements(string) - range.length;
		return (newLength > 15) ? false : true;
	}
	
	// MARK: - View Controller Life Cycle
	
    override func viewDidLoad() {
        super.viewDidLoad()

		player1.delegate = self
		player2.delegate = self
		player3.delegate = self
		player4.delegate = self
		
		let purchased = InAppPurchasesController.sharedInstance.isPurchased()
		for button in paidCurrencies {
			button.enabled = purchased
		}
    }
	
	override func viewDidAppear(animated: Bool) {
		loadingLabel.hidden = true
		loadingImage.hidden = true
		
		player1.becomeFirstResponder()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
