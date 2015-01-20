//
//  SavedGame.swift
//  Monopoly Banker
//
//  Created by Dmytro Bogatov on 1/18/15.
//  Copyright (c) 2015 Dmytro Bogatov. All rights reserved.
//

import UIKit

class SavedGame : NSObject {
	var ID : String
	var currency : String
	var finished : Bool
	var date : NSDate
	var accounts : [Account] = []
	
	
	init(currency: String, finished : Bool, date : NSDate, accounts : [Account]) {
		self.currency = currency
		self.finished = finished
		self.date = date
		self.accounts = accounts
		self.ID = "\(NSDate().timeIntervalSince1970)"
	}
	
	convenience init(currency : String, finished : Bool, date : NSDate, accounts : [Account], ID : String) {
		self.init(currency: currency, finished: finished, date: date, accounts: accounts)
		self.ID = ID
	}
	
	func deposit(amount : Int, name : String) {
		for acc in accounts {
			if acc.name == name {
				acc.deposit(amount)
			}
		}
	}
	
	func charge(amount : Int, name : String) -> Bool {
		for acc in accounts {
			if acc.name == name {
				return acc.charge(amount)
			}
		}
		return false
	}
	
	func getBalance(name : String) -> Int {
		for acc in accounts {
			if acc.name == name {
				return acc.getBalance()
			}
		}
		return -1
	}
	
	func description() -> String {
		var result : String = "";
		
		result += "ID: \(ID)\n"
		result += "Currency: \(currency)\n"
		result += "Finished: " + (finished ? "YES" : "NO") + "\n"
		result += "Date: \(date)\n"
		result += "Accounts:\n"
		for acc in accounts {
			result += "\t" + acc.description() + "\n"
		}
		
		return result
	}
}