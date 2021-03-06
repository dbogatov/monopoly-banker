//
//  StringExt.swift
//  Monopoly Banker
//
//  Created by Dmytro Bogatov on 1/18/15.
//  Copyright (c) 2015 Dmytro Bogatov. All rights reserved.
//

import Foundation

extension String {
	
	subscript (i: Int) -> Character {
		return self[advance(self.startIndex, i)]
	}
	
	subscript (i: Int) -> String {
		return String(self[i] as Character)
	}
	
	subscript (r: Range<Int>) -> String {
		return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
	}
	
	func lastElement() -> String {
		return self[countElements(self)-1]
	}
}