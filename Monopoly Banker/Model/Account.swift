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
	
	func description() -> String {
		return "\(name) : \(balance)"
	}
	
}

