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
	var currentGame : SavedGame?
	let initialBalance : Int = 15000
	
	var isGameSet : Bool = false
	
	override init() {
		super.init()
		seedFile("SavedGames", force: false)
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
	
	func seedFile(name : String, force : Bool = false) {
		let theFileManager = NSFileManager.defaultManager()
		
		if theFileManager.fileExistsAtPath(pathToDocsFolder(name)) && !force {
			println("File \(name) Found!")
		}
		else {
			// Copy the file from the Bundle and write it to the Device:
			let pathToBundledDB = NSBundle.mainBundle().pathForResource(name, ofType: "plist")
			let pathToDevice = pathToDocsFolder(name)
			
			if theFileManager.fileExistsAtPath(pathToDocsFolder(name)) {
				theFileManager.removeItemAtPath(pathToDocsFolder(name), error: nil)
			}
			
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
			
			let ID : String = game["ID"] as String
			let currency : String = game["Currency"] as String
			let finished : Bool = game["Finished"] as Bool
			let date : NSDate = game["Date"] as NSDate
			let accountsDic : NSArray = game["Accounts"] as NSArray
			var accounts : [Account] = []
			
			for account in accountsDic {
				accounts.append(Account(name: account["Name"] as String, balance: account["Balance"] as Int))
			}
			
			savedGames.append(SavedGame(currency: currency, finished: finished, date: date, accounts: accounts, ID : ID))
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
	
	func writeGames() {
		let path = pathToDocsFolder("SavedGames")
		
		var result : NSMutableArray = [];
		for game in savedGames {
			var record : NSMutableDictionary = [:]
			
			record.setValue(game.ID, forKey: "ID")
			record.setValue(game.currency, forKey: "Currency")
			record.setValue(game.finished, forKey: "Finished")
			record.setValue(game.date, forKey: "Date")
			
			var accounts : [NSDictionary] = []
			
			for acc in game.accounts {
				accounts.append(["Name" : acc.name, "Balance" : acc.balance])
			}
			
			record.setValue(accounts, forKey: "Accounts")
			
			result.addObject(record)
		}
		
		result.writeToFile(path, atomically: true)
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
	
	func printCurrentGame() {
		println("**********")
		println(currentGame!.description())
		println("**********")
	}
	
	// MARK: - Game functions
	
	func startNewGame(currency: String, names : [String]) {
		isGameSet = true
		
		var accounts : [Account] = []
		for name in names {
			accounts.append(Account(name: name, balance: initialBalance))
		}
		
		currentGame = SavedGame(currency: currency, finished: false, date: NSDate(), accounts: accounts)
		
		savedGames.append(currentGame!)
	}
	
	func loadGame(ID : String) {
		for game in savedGames {
			if game.ID == ID {
				currentGame = game
			}
		}
	}
	
	func saveGame() {
		writeGames()
	}
	
	func deposit(amount : Int, name : String) {
		currentGame?.deposit(amount, name: name)
		
		saveGame()
	}
	
	func charge(amount : Int, name : String) -> Bool {
		var result : Bool = currentGame!.charge(amount, name: name)
		saveGame()
		
		return result
	}
	
	func getBalance(name : String) -> Int {
		return currentGame!.getBalance(name)
	}
	
	func setStatusForID(ID : String, value : Bool) {
		for game in savedGames {
			if game.ID == ID {
				game.finished = value
			}
		}
		
		saveGame()
	}
	
	// MARK: - Helpers
	
	func getNumberOfActive() -> Int {
		var result : Int = 0
		for game in savedGames {
			if !game.finished {
				result++
			}
		}
		return result
	}
	
	func getNumberOfFinished() -> Int {
		return savedGames.count - getNumberOfActive()
	}
	
	func sortGames() {
		savedGames.sort({ $0.sortingID > $1.sortingID})
	}
	
}
