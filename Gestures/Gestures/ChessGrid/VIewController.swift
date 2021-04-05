//
//  ViewController.swift
//  Gestures
//
//  Created by Amir Zigangaraev on 23.03.2021.
//

import UIKit

class ViewController: UIViewController {

	private var checkerGrid: CheckerGrid? = nil
	private var button: UIButton? = nil
	private var colorFlag: Bool = true

	override func viewDidLoad() {
		super.viewDidLoad()

		self.button = UIButton(frame: CGRect(x: 20, y: 600, width: 400, height: 50))

		if let button = self.button {
			button.backgroundColor = .white
			button.setTitle("Take checker piece", for: .normal)
			button.setTitleColor(.black, for: .normal)
			button.addTarget(
				self, action: #selector(buttonAction), for: .touchUpInside)

			self.view.addSubview(button)
		}

		self.checkerGrid = CheckerGrid(
			gridDimension: 5,
			frame: CGRect(origin: .zero, size: CGSize(width: 300, height: 300)))

		if let checkerGrid = self.checkerGrid {
			self.view.addSubview(checkerGrid)
		}

		self.addCheckerPiece()
	}

	func addCheckerPiece() {
		if let checkerGrid = self.checkerGrid {
			if colorFlag {
				let piece = CheckerPiece(fillColor: UIColor.white.cgColor)

				piece.superViewDelegate = self.view
				piece.checkerGridDelegate = checkerGrid

				self.view.addSubview(piece)
			} else {
				let piece = CheckerPiece(fillColor: UIColor.red.cgColor)

				piece.superViewDelegate = self.view
				piece.checkerGridDelegate = checkerGrid

				self.view.addSubview(piece)
			}

			colorFlag.toggle()
		}
	}

	@objc func buttonAction(sender: UIButton!) {
		self.addCheckerPiece()
	}

}
