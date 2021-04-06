//
//  CheckerFieldView.class
//  Ceckers
//
//  Created by Никита Ляпустин on 04.04.2021.
//
import UIKit

class CheckerFieldView: UIView {

	override func awakeFromNib() {
		super.awakeFromNib()
		setupField()
		setupCircles()
	}

	var rects: [CGRect] = []
	var rectsFilling: [Bool] = []

	private func setupField() {
		let bezierPath = UIBezierPath()
		for level in 0...3 {
			for position in 0...3 {
				if (level + position) % 2 == 0 {
					let start = CGPoint(x: position * 50, y: level * 50)
					bezierPath.move(to: start)
					bezierPath.addLine(to: CGPoint(x: start.x + 50, y: start.y))
					bezierPath.addLine(to: CGPoint(x: start.x + 50, y: start.y + 50))
					bezierPath.addLine(to: CGPoint(x: start.x, y: start.y + 50))
					bezierPath.close()
				}
				rects.append(CGRect(x: position * 50, y: level * 50, width: 50, height: 50))
				rectsFilling.append(false)
			}
		}
		let cgPath = bezierPath.cgPath
		let layer = CAShapeLayer()
		layer.fillColor = UIColor.black.cgColor
		layer.path = cgPath
		self.layer.addSublayer(layer)

		// грязь какая-то, не понял, как по-другому сделать

		let bezierPathForPlacholder = UIBezierPath()
		bezierPathForPlacholder.move(to: CGPoint(x: 0, y: 200))
		bezierPathForPlacholder.addLine(to: CGPoint(x: 200, y: 200))
		bezierPathForPlacholder.addLine(to: CGPoint(x: 200, y: 295))
		bezierPathForPlacholder.addLine(to: CGPoint(x: 0, y: 295))
		bezierPathForPlacholder.close()
		let cgPathForPlaceholder = bezierPathForPlacholder.cgPath
		let layerForPlacheloder = CAShapeLayer()
		layerForPlacheloder.fillColor = UIColor.white.cgColor
		layerForPlacheloder.path = cgPathForPlaceholder
		self.layer.addSublayer(layerForPlacheloder)
	}

	private func setupCircles() {
		
		for i in 0..<4 {
			let checker = Checker(frame: CGRect(x: i * 50 + 5, y: 205, width: 40, height: 40))
			checker.awakeFromNib()
			checker.delegate = self
			addSubview(checker)
		}

		for i in 0..<4 {
			let checker = Checker(frame: CGRect(x: i * 50 + 5, y: 250, width: 40, height: 40))
			checker.awakeFromNib()
			checker.delegate = self
			addSubview(checker)
		}
	}
}

extension CheckerFieldView: CheckerPositionDelegate {
	func checkPosition(checker: Checker) {

		let fromRectIndex = getRectIndex(by: checker.initialPosition)
		let toRectIndex = getRectIndex(by: checker.newPosition)

		if toRectIndex == -1 {
			UIView.transition(with: self, duration: 0.4, options: [.transitionCrossDissolve], animations: {
			  checker.removeFromSuperview()
			}, completion: nil)
			return
		}

		if !rectsFilling[toRectIndex] {
			if fromRectIndex != -1 {
				rectsFilling[fromRectIndex] = false
			}
			rectsFilling[toRectIndex] = true
			UIView.animate(withDuration: 0.4) {
				checker.center = CGPoint(
					x: self.rects[toRectIndex].midX,
					y: self.rects[toRectIndex].midY)
			}
			checker.initialPosition = checker.newPosition
		} else {
			UIView.animate(withDuration: 0.4) {
				if fromRectIndex != -1 {
					checker.center = CGPoint(x: self.rects[fromRectIndex].midX,
											 y: self.rects[fromRectIndex].midY)
				} else {
					checker.center = checker.initialPosition
				}
			}
		}
	}

//	лол
	func getRectIndex(by point: CGPoint) -> Int {
		for i in 0..<16 {
			if rects[i].contains(point) {
				return i
			}
		}
		return -1
	}
}
