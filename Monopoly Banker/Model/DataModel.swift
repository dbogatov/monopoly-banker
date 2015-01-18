//
//  DataModel.swift
//  Monopoly Banker
//
//  Created by Dmytro Bogatov on 1/18/15.
//  Copyright (c) 2015 Dmytro Bogatov. All rights reserved.
//

import UIKit

class DataModel: NSObject {
	
	var savedGames : [SavedGame] = []
	
	override init() {
		super.init()
		readSavedGames()
	}
	
    class var sharedInstance : DataModel {
        struct Static {
            static let instance : DataModel = DataModel()
        }
        return Static.instance
    }
	
	func readSavedGames() {
		savedGames.removeAll()
		
		var sgArray : NSArray = []
		if let path = NSBundle.mainBundle().pathForResource("SavedGames", ofType: "plist") {
			sgArray = NSArray(contentsOfFile: path)!
		}
		
		for game in sgArray {
			
			let finished : Bool = game["Finished"] as Bool
			let date : NSDate = game["Date"] as NSDate
			let accountsDic : NSArray = game["Accounts"] as NSArray
			var accounts : [Account] = []
			
			for account in accountsDic {
				accounts.append(Account(name: account["Name"] as String, balance: account["Balance"] as Int))
			}
			
			savedGames.append(SavedGame(finished: finished, date: date, accounts: accounts))
		}
	}
	
	func printSavedGames() {
		for game in savedGames {
			print(game.description()+"\n ********** \n")
		}
	}
	
	
	
}

struct SavedGame {
	var finished : Bool
	var date : NSDate
	var accounts : [Account]
	
	init(finished : Bool, date : NSDate, accounts : [Account]) {
		self.finished = finished
		self.date = date
		self.accounts = accounts
	}
	
	 func description() -> String {
		var result : String = "";
		
		result += "Finished: " + (finished ? "YES" : "NO") + "\n"
		result += "Date: \(date)\n"
		result += "Accounts:\n"
		for acc in accounts {
			result += "\t" + acc.description() + "\n"
		}
		
		return result
	}
}

struct Account {
	var name : String
	var balance : Int
	
	init(name : String, balance : Int) {
		self.name = name
		self.balance = balance
	}
	
	func description() -> String {
		return "\(name) : \(balance)"
	}
}