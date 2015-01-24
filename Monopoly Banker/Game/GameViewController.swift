//
//  GameViewController.swift
//  Monopoly Banker
//
//  Created by Dmytro Bogatov on 1/17/15.
//  Copyright (c) 2015 Dmytro Bogatov. All rights reserved.
//

import UIKit
import QuartzCore
import iAd

class GameViewController: UIViewController, ADBannerViewDelegate {

	var cardObject : String = ""
	var secondCard : String = ""
	
	var displayAmount : Double = 0.0
	var displayMultiplier : Multiplier = .N
	var displayText : String = ""
	
	var dotExists : Bool = false
	var decimalExists : Bool = false
	
	var allowForSecondCard : Bool = false
	
	@IBOutlet weak var display: UILabel!
	@IBOutlet weak var multiplier: UILabel!
	@IBOutlet weak var currency: UILabel!
	
	@IBOutlet weak var player1: UIButton!
	@IBOutlet weak var player2: UIButton!
	@IBOutlet weak var player3: UIButton!
	@IBOutlet weak var player4: UIButton!
	
	@IBOutlet var adBanners: [ADBannerView]!
	
	@IBAction func backspacePressed(sender: UIButton) {
		if displayText == "" || displayText == "" {
			SoundController.sharedInstance.error()
		} else if displayText.lastElement() == "." {
			displayText = dropLast(displayText)
			dotExists = false
			
			SoundController.sharedInstance.numberPressed()
		} else if decimalExists {
			displayText = dropLast(displayText)
			decimalExists = false
			
			displayAmount = floor(displayAmount)
			
			SoundController.sharedInstance.numberPressed()
		} else {
			displayText = dropLast(displayText)
			
			displayAmount = floor(displayAmount / 10)
			
			SoundController.sharedInstance.numberPressed()
		}
		
		updateDisplay()
	}
	
	@IBAction func dotPressed(sender: UIButton) {
		if cardObject != "" && !dotExists {
			dotExists = true
			displayText += "."
			
			SoundController.sharedInstance.numberPressed()
		} else {
			SoundController.sharedInstance.error()
		}
		
		updateDisplay()
	}
	
	
	@IBAction func buttonPressed(sender: UIButton) {
		var number : Int = sender.titleLabel!.text!.toInt()!
		
		if cardObject != "" {
			
			if displayAmount == 0 && number == 0 {
				SoundController.sharedInstance.error()
			} else if decimalExists {
				SoundController.sharedInstance.error()
			} else if dotExists {
				displayAmount += Double(number) * 0.1
				decimalExists = true
				displayText += "\(number)"
				
				SoundController.sharedInstance.numberPressed()
			} else {
				var newNum : Double = displayAmount * 10 + Double(number)
				
				if newNum > 999 {
					SoundController.sharedInstance.error()
				} else {
					displayAmount = newNum
					displayText += "\(number)"
					
					SoundController.sharedInstance.numberPressed()
				}
			}
		} else {
			SoundController.sharedInstance.error()
		}
		
		updateDisplay()
	}
	
	@IBAction func multiplierButtonPressed(sender: UIButton) {
		if cardObject != "" {
			switch sender.titleLabel!.text! {
				case "K":
					displayMultiplier = (displayMultiplier != .K ? .K : .N)
				case "M":
					displayMultiplier = (displayMultiplier != .M ? .M : .N)
			default:
					displayMultiplier = .N
			}
			
			SoundController.sharedInstance.numberPressed()
		} else {
			SoundController.sharedInstance.error()
		}
		updateDisplay()
	}
	
	@IBAction func actionButonPressed(sender: UIButton) {
		var error : Bool = false
		
		if cardObject != "" && !(dotExists && displayMultiplier == .N) {
			switch sender.titleLabel!.text! {
				case "-":
					if !DataModel.sharedInstance.charge(getAmount(), name: cardObject) {
						error = true
					}
				case "+":
					DataModel.sharedInstance.deposit(getAmount(), name: cardObject)
					//println("\nDisplayed number is \(getAmount())")
				default:
					allowForSecondCard = true
					return
			}
		} else {
			error = true
		}
		
		if !error {
			SoundController.sharedInstance.balanceChanged()
			endTransaction()
		} else {
			SoundController.sharedInstance.error()
		}
	}
	
	@IBAction func cardButtonPressed(sender: UIButton) {
		
		if cardObject == "" {
			sender.setHighlighted(true)
			cardObject = sender.titleLabel!.text!
			display.text = "\(convertAmount(DataModel.sharedInstance.getBalance(cardObject)))"
		} else if cardObject == sender.titleLabel!.text! {
			endTransaction()
		} else if allowForSecondCard {
			if !DataModel.sharedInstance.charge(getAmount(), name: cardObject) {
				SoundController.sharedInstance.error()
			} else {
				DataModel.sharedInstance.deposit(getAmount(), name: sender.titleLabel!.text!)
			}
			SoundController.sharedInstance.balanceChanged()
			
			endTransaction()
		} else {
			SoundController.sharedInstance.error()
		}
	}
	
	
    @IBAction func saveAndExit() {
		DataModel.sharedInstance.isGameSet = false
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    

	func endTransaction() {
		DataModel.sharedInstance.printCurrentGame()
		
		displayMultiplier = .N
		displayAmount = 0
		displayText = ""
		
		cardObject = ""
		secondCard = ""
		
		dotExists = false
		decimalExists = false
		
		allowForSecondCard = false
		
		player1.setHighlighted(false)
		player2.setHighlighted(false)
		player3.setHighlighted(false)
		player4.setHighlighted(false)
		
		updateDisplay()
	}
	
	func updateDisplay() {
		display.text = displayText
		
		switch displayMultiplier {
		case .M:
			multiplier.text = "M"
		case .K:
			multiplier.text = "K"
		default:
			multiplier.text = ""
		}
	}
	
	func getAmount() -> Int {
		var result : Double = displayAmount
		switch displayMultiplier {
		case .K:
			result *= 1000
		case .M:
			result *= 1000000
		default:
			result *= 1
		}
		
		return Int(result)
	}
	
	func updateUI() {
		var game : SavedGame = DataModel.sharedInstance.currentGame!
		
		player1.setTitle( (game.accounts.count > 0 ? game.accounts[0].name : ""), forState: UIControlState.Normal)
		player2.setTitle( (game.accounts.count > 1 ? game.accounts[1].name : ""), forState: UIControlState.Normal)
		player3.setTitle( (game.accounts.count > 2 ? game.accounts[2].name : ""), forState: UIControlState.Normal)
		player4.setTitle( (game.accounts.count > 3 ? game.accounts[3].name : ""), forState: UIControlState.Normal)
	}
	
	func updateAds() {
		if InAppPurchasesController.sharedInstance.isPurchased() {
			for banner in adBanners {
				banner.hidden = true
			}
		}
	}
	
	func bannerViewWillLoadAd(banner: ADBannerView!) {
		if banner.hidden && !InAppPurchasesController.sharedInstance.isPurchased() {
			banner.hidden = false
		}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

		currency.text = DataModel.sharedInstance.currentGame!.currency
		
		updateAds()
        updateDisplay()
		updateUI()
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func convertAmount(number : Int) -> String {
		if number > 999999 {
			multiplier.text = "M"
			println("Ammount: \(round(10 * (Double(number)/1000000))/10)")
			return "\(round(10 * (Double(number)/1000000))/10 )"
		} else if number > 999 {
			multiplier.text = "K"
			println("Ammount: \(round(10 * (Double(number)/1000))/10)")
			return "\(round(10 * (Double(number)/1000))/10)"
		} else {
			return "\(number)"
		}
	}
}

enum Multiplier {
	case M, K, N
}