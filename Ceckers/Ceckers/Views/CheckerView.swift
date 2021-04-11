//
//  Checker.py
//  Ceckers
//
//  Created by Никита Ляпустин on 04.04.2021.
//

import UIKit

protocol CheckerPositionDelegate: AnyObject {
	func checkPosition(checker: Checker)
	func getRectIndex(by point: CGPoint) -> Int
}

class Checker: UIImageView {

	weak var delegate: CheckerPositionDelegate?
	var initialPosition: CGPoint = CGPoint(x: 0, y: 0)
	var newPosition: CGPoint = CGPoint(x: 0, y: 0)

	override func awakeFromNib() {
		super.awakeFromNib()
		isUserInteractionEnabled = true
		drawCircle()
		let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
		addGestureRecognizer(panGestureRecognizer)
		initialPosition = center
	}

	func drawCircle() {
		let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))

		let img = renderer.image { ctx in
			ctx.cgContext.setFillColor(UIColor.white.cgColor)
			ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
			ctx.cgContext.setLineWidth(2)
			ctx.cgContext.addEllipse(in: bounds.insetBy(dx: 2, dy: 2))
			ctx.cgContext.drawPath(using: .fillStroke)
		}

		image = img
	}

	@objc private func handlePan(_ panRecognizer: UIPanGestureRecognizer) {
		switch panRecognizer.state {
		case .began:
			initialPosition = panRecognizer.location(in: superview)
		case .changed:
			let translation = panRecognizer.translation(in: superview)
			center = CGPoint(x: initialPosition.x + translation.x,
							 y: initialPosition.y + translation.y)
		case .ended:
			newPosition = center
			delegate?.checkPosition(checker: self)
		default:
			break
		}
	}
}
