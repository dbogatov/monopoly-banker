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
	var isFirstLaunch : Bool = false
	
	override init() {
		super.init()
		seedFile("SavedGames")
		seedFile("FirstTimeLaunch")
		readSavedGames()
		readFistTimeLaunch()
	}
	
    class var sharedInstance : DataModel {
        struct Static {
            static let instance : DataModel = DataModel()
        }
        return Static.instance
    }
	
	// MARK: - Seed functions
	
	func pathToDocsFolder(name : String) -> String {
		let pathToDocumentsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
		
		return pathToDocumentsFolder.stringByAppendingPathComponent("/"+name+".plist")
	}
	
	func seedFile(name : String) {
		let theFileManager = NSFileManager.defaultManager()
		
		if theFileManager.fileExistsAtPath(pathToDocsFolder(name)) {
			println("File \(name) Found!")
		}
		else {
			// Copy the file from the Bundle and write it to the Device:
			let pathToBundledDB = NSBundle.mainBundle().pathForResource(name, ofType: "plist")
			let pathToDevice = pathToDocsFolder(name)
			
			// Here is where I get the error:
			if (theFileManager.copyItemAtPath(pathToBundledDB!, toPath:pathToDevice, error:nil)) {
				println("File \(name) Copied!")
			}
			else {
				println("Error with file \(name) !")
			}
		}
	}
	
	// MARK: - Read functions
	
	func readSavedGames() {
		savedGames.removeAll()
		
		var sgArray : NSArray = []
		let path = pathToDocsFolder("SavedGames")
		sgArray = NSArray(contentsOfFile: path)!
		
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
	
	func readFistTimeLaunch() {
		let path = pathToDocsFolder("FirstTimeLaunch")
		let dict : NSDictionary = NSDictionary(contentsOfFile: path)!
		isFirstLaunch = dict["FirstTimeLaunch"] as Bool
	}
	
	// MARK: - Write functions
	
	func writeFistTimeLaunch() {
		isFirstLaunch = false
		
		let path = pathToDocsFolder("FirstTimeLaunch")
		let toSave : NSDictionary = ["FirstTimeLaunch": false]
		toSave.writeToFile(path, atomically: true)
	}
	
	// MARK: - Print functions
	
	func printSavedGames() {
		for game in savedGames {
			print(game.description()+"\n ********** \n")
		}
	}
	
	func printFistTimeLaunch() {
		println("First time launch: " + (isFirstLaunch ? "YES" : "NO"))
	}

}
	


// MARK: - Supporting structures

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