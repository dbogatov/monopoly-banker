//
//  GameViewController.swift
//  Monopoly Banker
//
//  Created by Dmytro Bogatov on 1/17/15.
//  Copyright (c) 2015 Dmytro Bogatov. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

	var cardObject : String = ""
	var secondCard : String = ""
	var displayAmount : Int = 0
	var displayMultiplier : Multiplier = .N
	
	@IBOutlet weak var display: UILabel!
	
	@IBOutlet weak var player1: UIButton!
	@IBOutlet weak var player2: UIButton!
	@IBOutlet weak var player3: UIButton!
	@IBOutlet weak var player4: UIButton!
	
	@IBAction func buttonPressed(sender: UIButton) {
		var number : Int = sender.titleLabel!.text!.toInt()!
		var newNum : Int = displayAmount * 10 + number
		
		if newNum > 999 {
			SoundController.sharedInstance.error()
		} else {
			displayAmount = newNum
			SoundController.sharedInstance.numberPressed()
		}
		updateDisplay()
	}
	
	@IBAction func multiplierButtonPressed(sender: UIButton) {
		switch sender.titleLabel!.text! {
			case "K":
				displayMultiplier = .K
			case "M":
				displayMultiplier = .M
		default:
				displayMultiplier = .N
		}
		updateDisplay()
	}
	
	@IBAction func actionButonPressed(sender: UIButton) {
		var error : Bool = false
		switch sender.titleLabel!.text! {
			case "-":
				if !DataModel.sharedInstance.charge(getAmount(), name: cardObject) {
					SoundController.sharedInstance.error()
					error = true
				}
			case "+":
				DataModel.sharedInstance.deposit(getAmount(), name: cardObject)
			default:
				if !DataModel.sharedInstance.charge(getAmount(), name: cardObject) {
					SoundController.sharedInstance.error()
					error = true
				}
				DataModel.sharedInstance.deposit(getAmount(), name: secondCard)
		}
		if !error {
			SoundController.sharedInstance.balanceChanged()
		}
		endTransaction()
	}
	
	@IBAction func cardButtonPressed(sender: UIButton) {
		cardObject = sender.titleLabel!.text!
	}
	
	
    @IBAction func saveAndExit() {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    

	func endTransaction() {
		displayMultiplier = .N
		displayAmount = 0
		cardObject = ""
		secondCard = ""
		updateDisplay()
	}
	
	func updateDisplay() {
		var result : String = "\(displayAmount)"
		switch displayMultiplier {
		case .M:
			result += "M"
		case .K:
			result += "K"
		default:
			result += ""
		}
		display.text = result
	}
	
	func getAmount() -> Int {
		var result : Int = displayAmount
		switch displayMultiplier {
		case .K:
			result *= 1000
		case .M:
			result *= 1000000
		default:
			result *= 1
		}
		
		return result
	}
	
	func updateUI() {
		var game : SavedGame = DataModel.sharedInstance.currentGame!
		
		player1.setTitle( (game.accounts.count > 0 ? game.accounts[0].name : ""), forState: UIControlState.Normal)
		player2.setTitle( (game.accounts.count > 1 ? game.accounts[1].name : ""), forState: UIControlState.Normal)
		player3.setTitle( (game.accounts.count > 2 ? game.accounts[2].name : ""), forState: UIControlState.Normal)
		player4.setTitle( (game.accounts.count > 3 ? game.accounts[3].name : ""), forState: UIControlState.Normal)
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

        updateDisplay()
		updateUI()
		
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

enum Multiplier {
	case M, K, N
}