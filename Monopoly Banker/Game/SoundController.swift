//
//  SoundController.swift
//  Monopoly Banker
//
//  Created by Dmytro Bogatov on 1/18/15.
//  Copyright (c) 2015 Dmytro Bogatov. All rights reserved.
//

import UIKit
import AVFoundation

class SoundController: NSObject {
	
	var errorBeep = AVAudioPlayer()
	var numberBeep = AVAudioPlayer()
	var changeBeep = AVAudioPlayer()
	
	override init() {
		super.init()
		
		errorBeep = self.setupAudioPlayerWithFile("errorSound", type:"wav")
		numberBeep = self.setupAudioPlayerWithFile("ButtonTap", type:"wav")
		changeBeep = self.setupAudioPlayerWithFile("cashSound", type:"mp3")
	}
	
	class var sharedInstance : SoundController {
		struct Static {
			static let instance : SoundController = SoundController()
		}
		return Static.instance
	}

	
	func error() {
		errorBeep.play()
	}
	
	func numberPressed() {
		numberBeep.play()
	}
	
	func balanceChanged() {
		changeBeep.play()
	}
	
	func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer  {
		//1
		var path = NSBundle.mainBundle().pathForResource(file, ofType:type)
		var url = NSURL.fileURLWithPath(path!)
				
		//2
		var error: NSError?
				
		//3
		var audioPlayer:AVAudioPlayer?
		audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
				
		//4
		return audioPlayer!
	}
}
