//
//  ViewController.swift
//  Checkers
//
//  Created by Albert Ahmadiev on 04.04.2021.
//

import UIKit

class ViewController: UIViewController, CheckerViewDelegate {

	// MARK: Private Properities

	private var rows: Int = 4
	private var columns: Int = 4
	private var tileWidth: CGFloat?

	private var tiles: [CGRect] = []
	private var tilesIsEmpty: [Bool] = []




	// MARK: Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		draw()
	}


	// MARK: Private

	public func draw() {
		let tileWidth = self.view.frame.width / CGFloat(columns)

		let bezierPath = UIBezierPath()

		for i in 0...rows - 1 {
			for j in 0...columns - 1 {
				let y = CGFloat(i) * tileWidth + self.view.frame.height / CGFloat(5)
				let x = CGFloat(j) * tileWidth
				if (i + j) % 2 == 0 {
					setTile(bezierPath: bezierPath, width: tileWidth, x: x, y: y)
				}
				let rect = CGRect(x: x, y: y, width: tileWidth, height: tileWidth)
				tiles.append(rect)
				tilesIsEmpty.append(true)
			}
		}

		let cgPath = bezierPath.cgPath
		let layer = CAShapeLayer()
		layer.fillColor = UIColor.darkGray.cgColor
		layer.path = cgPath
		self.view.layer.addSublayer(layer)

		// Create checkers
		createCheckers()
	}


	//MARK: Private

	private func setTile(bezierPath: UIBezierPath, width: CGFloat, x: CGFloat, y: CGFloat) {
		bezierPath.move(to: CGPoint(x: x, y: y))
		bezierPath.addLine(to: CGPoint(x: x + width, y: y))
		bezierPath.addLine(to: CGPoint(x: x + width, y: y + width))
		bezierPath.addLine(to: CGPoint(x: x, y: y + width))
		bezierPath.close()
	}

	private func createCheckers() {
		let tileWidth = self.view.frame.width / CGFloat(rows) - CGFloat(10)

		for i in 1...(4 * (rows)) {
			if i % 2 == 0 {
				let checker =  CheckerView(color: .red, frame: CGRect(x: self.view.frame.width / CGFloat(2) - tileWidth, y:  CGFloat(rows) * tileWidth + self.view.frame.height / CGFloat(3), width: tileWidth, height: tileWidth))
				checker.delegate = self
				view.addSubview(checker)
			} else {
				let checker =  CheckerView(color: .systemGreen, frame: CGRect(x: self.view.frame.width / CGFloat(2), y:  CGFloat(rows) * tileWidth + self.view.frame.height / CGFloat(3), width: tileWidth, height: tileWidth))
				checker.delegate = self
				view.addSubview(checker)
			}
		}
	}

	func whichTileIndex(position: CGPoint) -> Int? {
		for i in 0...rows * columns - 1 {
			if tiles[i].contains(position) { return i }
		}
		return nil
	}

	// MARK: Delegat method
	func pan(checkerView: CheckerView, moveTo: CGPoint) {

		guard let i = whichTileIndex(position: moveTo) else {
			if let outOfIndex = checkerView.tileIndex{
				tilesIsEmpty[outOfIndex] = true
			}
			checkerView.deleteFromBoard(view: self)
			return
		}

		let tile = tiles[i]

		if tilesIsEmpty[i] {
			if let outOfIndex = checkerView.tileIndex{
				tilesIsEmpty[outOfIndex] = true
			}
			checkerView.moveChecker(to: tile.midX, to: tile.midY)
			checkerView.tileIndex = i
			tilesIsEmpty[i] = false
		} else {
			checkerView.moveChecker(to: checkerView.position.x, to: checkerView.position.y)
		}
	}
}


