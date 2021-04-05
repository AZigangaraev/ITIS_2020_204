//
//  ChessPiece.swift
//  Gestures
//
//  Created by Joseph on 05.04.2021.
//

import Foundation
import UIKit

class CheckerPiece: UIView {
	private let fillColor: CGColor
	private let strokeColor: CGColor = UIColor.systemGray6.cgColor

	public weak var superViewDelegate: UIView?
	public var checkerGridDelegate: CheckerGridDelegate?

	init(fillColor: CGColor) {
		self.fillColor = fillColor
		super.init(frame: CGRect(x: 200, y: 500, width: 45, height: 45))
		backgroundColor = .clear
		clipsToBounds = false
		gestureRecognizers = [
			UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
		]
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func draw(_ rect: CGRect) {
		guard let context = UIGraphicsGetCurrentContext() else { return }

		context.setFillColor(fillColor)
		context.setStrokeColor(strokeColor)
		context.setLineWidth(4)
		context.addEllipse(in: bounds.insetBy(dx: 4, dy: 4))
		context.drawPath(using: .fillStroke)
	}

	private var initialPosition: CGPoint?
	private var latestPosition: CGPoint?

	@objc private func handlePan(_ gestureRecognizer: UITapGestureRecognizer) {
		switch gestureRecognizer.state {
		case .began:
			initialPosition = gestureRecognizer.location(in: self)
			self.latestPosition = self.center
            
            self.checkerGridDelegate?.freeCell(for: latestPosition ?? .zero)
		case .changed:
			self.frame.origin = gestureRecognizer.location(
				in: superViewDelegate ?? self
			)
			.applying(
				CGAffineTransform(
					translationX: -(initialPosition?.x ?? 0),
					y: -(initialPosition?.y ?? 0)
				)
			)
			self.latestPosition = self.center
		case .ended:
			self.center =
				checkerGridDelegate?.closestPosition(for: latestPosition ?? .zero)
				?? .zero
            
            if (self.center == .zero) {
                self.removeFromSuperview()
            }
		default:
			break
		}
	}
}
