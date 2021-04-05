//
//  CheckerGrid.swift
//  Gestures
//
//  Created by Joseph on 05.04.2021.
//

import Foundation
import UIKit

protocol CheckerGridDelegate {
	func closestPosition(for point: CGPoint) -> CGPoint
	func freeCell(for point: CGPoint)
	func getCheckerPieceSize() -> CGFloat
}

class CheckerGrid: UIView, CheckerGridDelegate {
	private var pieceCenters: [CGPoint] = []
	private var takenCenters: [CGPoint] = []

	//MARK: - Drawing Constants

	private let viewSide: CGFloat
	private let gridDimension: Int
	private var squareSide: CGFloat {
		min(96.0, viewSide / CGFloat(gridDimension))
	}

	init(gridDimension: Int, frame: CGRect) {
		self.gridDimension = gridDimension
		self.viewSide = min(frame.maxY - frame.minY, frame.maxX - frame.minX)
		super.init(frame: frame)

		self.backgroundColor = .lightGray
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func draw(_ rect: CGRect) {
		guard let context = UIGraphicsGetCurrentContext() else {
			return
		}

		let fillColor = UIColor.white.cgColor
		context.setFillColor(fillColor)

		for row in 0...gridDimension {
			for col in 0...gridDimension {
				let x = CGFloat(col) * squareSide
				let y = CGFloat(row) * squareSide
				let frame = CGRect(
					x: x, y: y, width: squareSide, height: squareSide)
				pieceCenters.append(
					CGPoint(
						x: (frame.maxX - squareSide / 2),
						y: (frame.maxY - squareSide / 2)))
				if (row + col) % 2 == 0 {
					context.fill(frame)
				}
			}
		}
	}

	public func getCheckerPieceSize() -> CGFloat {
		squareSide
	}

	public func closestPosition(for point: CGPoint) -> CGPoint {
		var closestPoint: CGPoint?
		var minimumDistance: CGFloat = .greatestFiniteMagnitude

		if point.x > self.frame.maxX || point.y > self.frame.maxY {
			return .zero
		}

		pieceCenters.forEach {
			let distance =
				($0.x - point.x) * ($0.x - point.x) + ($0.y - point.y)
				* ($0.y - point.y)
			if minimumDistance > distance && !takenCenters.contains($0) {
				minimumDistance = distance
				closestPoint = $0
			}
		}

		if let cp = closestPoint {
			if cp.x > self.frame.maxX || cp.y > self.frame.maxY {
				return .zero
			} else {
				self.takenCenters.append(cp)
			}
		}

		return (closestPoint ?? .zero)
	}

	func freeCell(for point: CGPoint) {
		if let idx = self.takenCenters.firstIndex(of: point) {
			self.takenCenters.remove(at: idx)
		}
	}
}
