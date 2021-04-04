//
//  CheckerboardView.swift
//  Checkers
//
//  Created by Robert Mukhtarov on 03.04.2021.
//

import UIKit

class Position {
	let frame: CGRect
	var pieceView: PieceView?

	init(frame: CGRect, pieceView: PieceView? = nil) {
		self.frame = frame
		self.pieceView = pieceView
	}
}

class CheckerboardView: UIView {
	private var positions: [Position] = []

	init() {
		super.init(frame: CGRect(x: 0, y: 0, width: 320, height: 320))
		backgroundColor = .lightSquare
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func draw(_ rect: CGRect) {
		guard let context = UIGraphicsGetCurrentContext() else { return }
		let fillColor = UIColor.darkSquare.cgColor
		context.setFillColor(fillColor)

		for row in 0...3 {
			for col in 0...3 {
				let frame = CGRect(x: col * 80, y: row * 80, width: 80, height: 80)
				positions.append(Position(frame: frame))
				if (row + col) % 2 == 0 {
					context.fill(frame)
				}
			}
		}
	}
	
	func position(of point: CGPoint) -> Position? {
		for position in positions {
			if position.frame.contains(point) { return position }
		}
		return nil
	}

	func position(of pieceView: PieceView) -> Position? {
		for position in positions {
			if position.pieceView == pieceView { return position }
		}
		return nil
	}
}
