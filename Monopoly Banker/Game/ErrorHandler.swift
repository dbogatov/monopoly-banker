//
//  ErrorHandler.swift
//  Monopoly Banker
//
//  Created by Dmytro Bogatov on 1/30/15.
//  Copyright (c) 2015 Dmytro Bogatov. All rights reserved.
//

import UIKit

class ErrorHandler: NSObject {
   
    var label : UILabel?
    
    func setLabel(label : UILabel) {
        self.label = label
    }
    
    func displayErrorForAction(error : Error) {
        
        switch (error) {
        case .NothingToRemove:
            label?.text = "There is nothing to delete"
        case .NoCardChosen:
            label?.text = "Choose card first"
        case .NegativeBalance:
            label?.text = "Insufficient balance"
        case .MaxDigitsReached:
            label?.text = "You cannot enter more digits"
        case .DotExists:
            label?.text = "Dot is already there"
		case .NoFractions:
			label?.text = "Only whole numbers are allowed. 5.2 K is good, 5.2 is not."
		case .CardIsThere:
			label?.text = "Another card is inserted"
		case .ZeroItself:
			label?.text = "Zero is already there"
        }
		
		SoundController.sharedInstance.error()
		
        label?.hidden = false
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: Selector("hideError"), userInfo: nil, repeats: false)
    }
    
    func hideError() {
        label?.hidden = true
    }
}

enum Error {
    case NothingToRemove, NoCardChosen, NegativeBalance, MaxDigitsReached, DotExists, NoFractions, CardIsThere, ZeroItself
}