//
//  CheckerView.swift
//  Checkers
//
//  Created by Albert Ahmadiev on 04.04.2021.
//

import UIKit

protocol CheckerViewDelegate: AnyObject {
	func pan(checkerView: CheckerView, moveTo: CGPoint)
}

class CheckerView: UIView {

	// MARK: Private properties

	private var color: UIColor
	private var initialFrame = CGRect(x: 0, y: 0, width: 0, height: 0)

	
	// MARK: Public properties

	public var position = CGPoint(x: 0, y: 0)
	public var tileIndex: Int?

	//MARK: Delegat

	weak var delegate: CheckerViewDelegate?




	// MARK: Lifecycle

	init (color: UIColor, frame: CGRect) {
		self.color = color
		self.initialFrame = frame
		super.init(frame: frame)
		self.backgroundColor = .clear
		self.isUserInteractionEnabled = true
		self.gestureRecognizers = [UIPanGestureRecognizer(target: self, action: #selector(pan))]
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func draw(_ rect: CGRect) {
		guard let context = UIGraphicsGetCurrentContext() else { return }

		context.addEllipse(in: bounds.insetBy(dx: 4, dy: 4))
		context.setLineWidth(5)
		context.setFillColor(self.color.cgColor)
		context.setStrokeColor(UIColor.black.cgColor)
		context.drawPath(using: .fillStroke)
	}


	// MARK: Public

	public func deleteFromBoard(view: UIViewController) {
		UIView.animate(withDuration: 1.0) {
			self.frame = CGRect(x: self.frame.midX, y: self.frame.midY, width: 0, height: 0)
			self.alpha = 0
		} completion: { _ in
			UIView.animate(withDuration: 1.0) {
				self.frame = self.initialFrame
				self.alpha = 1
			}
		}
	}

	public func moveChecker(to x: CGFloat, to y: CGFloat){
		UIView.transition(with: self, duration: 1, options: .transitionFlipFromBottom) {
			self.center.x = x
			self.center.y = y
		}
	}


	// MARK: Private

	@objc private func pan(_ recognizer: UIPanGestureRecognizer) {
		switch recognizer.state {
		case .began:
			position.x = self.frame.midX
			position.y = self.frame.midY
		case .changed:
			let recognizerLocation = recognizer.location(in: superview)
			self.center = CGPoint(x: CGFloat(0) + recognizerLocation.x, y: CGFloat(0) + recognizerLocation.y)
		case .ended:
			delegate?.pan(checkerView: self, moveTo: self.center)
		default:
			break
		}
	}
}
