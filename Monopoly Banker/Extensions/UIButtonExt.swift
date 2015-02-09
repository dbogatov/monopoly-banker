//
//  UIButtonExt.swift
//  Monopoly Banker
//
//  Created by Dmytro Bogatov on 1/18/15.
//  Copyright (c) 2015 Dmytro Bogatov. All rights reserved.
//

import UIKit

extension UIButton {
	
	func setColor(color: UIColor, state: UIControlState) {
		let cornerRadius = self.layer.cornerRadius
		
		var colorView : UIView = UIView(frame: self.frame)
		colorView.backgroundColor = color
		
		UIGraphicsBeginImageContext(colorView.bounds.size);
		colorView.layer.renderInContext(UIGraphicsGetCurrentContext())
		
		var colorImage : UIImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
		self.setBackgroundImage(colorImage, forState: state)
		
	}
	
	func setHighlighted(flag : Bool) {
		if flag {
			self.layer.borderWidth = 3.0
			self.layer.borderColor = UIColor.redColor().CGColor
		} else {
			self.layer.borderWidth = 0.0
			self.layer.borderColor = UIColor.clearColor().CGColor
		}
	}
}