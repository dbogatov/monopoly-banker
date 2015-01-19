//
//  Account.swift
//  Monopoly Banker
//
//  Created by Dmytro Bogatov on 1/18/15.
//  Copyright (c) 2015 Dmytro Bogatov. All rights reserved.
//

import UIKit

class Account : NSObject {
	var name : String = ""
	var balance : Int = 0
	
	init(name : String, balance : Int) {
		self.name = name
		self.balance = balance
	}
	
	func deposit(amount : Int) {
		balance += amount
	}
	
	func charge(amount : Int) -> Bool {
		if amount <= balance {
			balance -= amount
			return true
		} else {
			return false
		}
	}
	
	func getBalance() -> Int {
		return balance
	}
		
	func description() -> String {
		return "\(name) : \(balance)"
	}
	
}

