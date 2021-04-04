//
//  PieceView.swift
//  Checkers
//
//  Created by Robert Mukhtarov on 03.04.2021.
//

import UIKit

protocol PieceViewDelegate: AnyObject {
	func pieceView(_ pieceView: PieceView, movedTo point: CGPoint)
}

class PieceView: UIView {
	let color: PieceColor
	var initialPosition = CGPoint(x: 0, y: 0)
	
	weak var delegate: PieceViewDelegate?
	
	init(color: PieceColor) {
		self.color = color
		super.init(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
		backgroundColor = .clear
		clipsToBounds = false
		gestureRecognizers = [UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))]
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override var intrinsicContentSize: CGSize {
		CGSize(width: 70, height: 70)
	}
	
	override func draw(_ rect: CGRect) {
		guard let context = UIGraphicsGetCurrentContext() else { return }
		
		let fillColor = color == .white ? UIColor.systemGray6.cgColor : UIColor.systemGray.cgColor
		let strokeColor = color == .white ? UIColor.systemGray4.cgColor : UIColor.darkGray.cgColor
		
		context.setFillColor(fillColor)
		context.setStrokeColor(strokeColor)
		context.setLineWidth(4)
		context.addEllipse(in: bounds.insetBy(dx: 4, dy: 4))
		context.drawPath(using: .fillStroke)
	}
	
	@objc private func handlePan(_ recognizer: UIPanGestureRecognizer) {
		switch recognizer.state {
		case .began:
			initialPosition = recognizer.location(in: superview)
			superview?.bringSubviewToFront(self)
		case .changed:
			let translation = recognizer.translation(in: superview)
			center = CGPoint(x: initialPosition.x + translation.x, y: initialPosition.y + translation.y)
		case .ended:
			delegate?.pieceView(self, movedTo: center)
		default:
			break
		}
	}
}

enum PieceColor {
	case white
	case black
}

