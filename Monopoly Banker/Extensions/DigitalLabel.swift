//
//  DigitalLabel.swift
//  Monopoly Banker
//
//  Created by Dmytro Bogatov on 2/9/15.
//  Copyright (c) 2015 Dmytro Bogatov. All rights reserved.
//

import UIKit

class DigitalLabel: UILabel {

	override func layoutSubviews() {
		super.layoutSubviews()
		
		self.font = UIFont(name: "DS-Digital", size: self.font.pointSize)
	}
	
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
