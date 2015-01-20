//
//  LoadGameTableViewCell.swift
//  Monopoly Banker
//
//  Created by Dmytro Bogatov on 1/17/15.
//  Copyright (c) 2015 Dmytro Bogatov. All rights reserved.
//

import UIKit

class LoadGameTableViewCell: UITableViewCell {

	var ID : String = ""
	var parent : LoadGameTableViewController?
	
    @IBOutlet weak var currentlyPlayingSwitch: UISwitch!
    @IBOutlet weak var cellTitle: UILabel!
	
	@IBOutlet weak var player1: UILabel!
	@IBOutlet weak var player2: UILabel!
	@IBOutlet weak var player3: UILabel!
	@IBOutlet weak var player4: UILabel!
	
	@IBOutlet weak var balance1: UILabel!
	@IBOutlet weak var balance2: UILabel!
	@IBOutlet weak var balance3: UILabel!
	@IBOutlet weak var balance4: UILabel!
	
	
	@IBAction func loadGame(sender: UIButton) {
		DataModel.sharedInstance.loadGame(ID)
		DataModel.sharedInstance.isGameSet = true
		parent?.dismissViewControllerAnimated(true, completion: nil)
	}
	
	func setDate(date : NSDate) {
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = "h: mm, EEE, MMM d, yyyy" // superset of OP's format
		cellTitle.text = dateFormatter.stringFromDate(date)
	}
	
	func setParent(parent : LoadGameTableViewController) {
		self.parent = parent
	}
	
	func setGame(game : SavedGame) {
		ID = game.ID
		setDate(game.date)
		currentlyPlayingSwitch.setOn(game.finished, animated: false)
		
		player1.text = game.accounts.count > 0 ? game.accounts[0].name : ""
		player2.text = game.accounts.count > 1 ? game.accounts[1].name : ""
		player3.text = game.accounts.count > 2 ? game.accounts[2].name : ""
		player4.text = game.accounts.count > 3 ? game.accounts[3].name : ""
		
		balance1.text = game.accounts.count > 0 ? "\(game.accounts[0].balance)" : ""
		balance2.text = game.accounts.count > 1 ? "\(game.accounts[1].balance)" : ""
		balance3.text = game.accounts.count > 2 ? "\(game.accounts[2].balance)" : ""
		balance4.text = game.accounts.count > 3 ? "\(game.accounts[3].balance)" : ""
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
