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
	var finished : Bool
	var date : NSDate
	var accounts : [Account] = []
	
	
	init(finished : Bool, date : NSDate, accounts : [Account]) {
		self.finished = finished
		self.date = date
		self.accounts = accounts
		self.ID = "\(NSDate().timeIntervalSince1970)"
	}
	
	convenience init(finished : Bool, date : NSDate, accounts : [Account], ID : String) {
		self.init(finished: finished, date: date, accounts: accounts)
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
	
	func description() -> String {
		var result : String = "";
		
		result += "ID: \(ID)\n"
		result += "Finished: " + (finished ? "YES" : "NO") + "\n"
		result += "Date: \(date)\n"
		result += "Accounts:\n"
		for acc in accounts {
			result += "\t" + acc.description() + "\n"
		}
		
		return result
	}
}