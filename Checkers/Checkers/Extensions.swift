//
//  Extensions.swift
//  Checkers
//
//  Created by Robert Mukhtarov on 04.04.2021.
//

import UIKit

extension UIColor {
	static var lightSquare: UIColor {
		UIColor(red: 0.95, green: 0.87, blue: 0.73, alpha: 1.00)
	}
	
	static var darkSquare: UIColor {
		UIColor(red: 0.71, green: 0.33, blue: 0.15, alpha: 1.00)
	}
}

extension CGRect {
	var center: CGPoint {
		CGPoint(x: (minX + maxX) / 2, y: (minY + maxY) / 2)
	}
}
