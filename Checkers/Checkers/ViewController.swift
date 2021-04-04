//
//  ViewController.swift
//  Checkers
//
//  Created by Robert Mukhtarov on 03.04.2021.
//

import UIKit

class ViewController: UIViewController {
	let checkerboard = CheckerboardView()
	let piecePlatform = PiecePlatformView()

	var whitePieceCenter = CGPoint(x: 0, y: 0)
	var blackPieceCenter = CGPoint(x: 0, y: 0)

	override func viewDidLoad() {
		super.viewDidLoad()
		setupCheckerboard()
		setupPiecePlatform()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		whitePieceCenter = piecePlatform.convert(piecePlatform.whitePiece.center, to: view)
		blackPieceCenter = piecePlatform.convert(piecePlatform.blackPiece.center, to: view)
		addMovablePiece(color: .white)
		addMovablePiece(color: .black)
	}

	private func setupCheckerboard() {
		checkerboard.center = view.center
		view.addSubview(checkerboard)
	}

	private func setupPiecePlatform() {
		piecePlatform.center = CGPoint(x: view.center.x, y: checkerboard.frame.maxY + 60)
		view.addSubview(piecePlatform)
	}

	private func addMovablePiece(color: PieceColor) {
		let piece: PieceView
		switch color {
		case .black:
			piece = PieceView(color: .black)
			piece.center = blackPieceCenter
		case .white:
			piece = PieceView(color: .white)
			piece.center = whitePieceCenter
		}
		piece.delegate = self
		view.addSubview(piece)
	}
}

extension ViewController: PieceViewDelegate {
	func pieceView(_ pieceView: PieceView, movedTo point: CGPoint) {
		let point = view.convert(point, to: checkerboard)
		let oldCenter: CGPoint
		let finishMove: () -> ()

		if let oldPosition = checkerboard.position(of: pieceView) {
			oldCenter = checkerboard.convert(oldPosition.frame.center, to: view)
			finishMove = { oldPosition.pieceView = nil }
		} else {
			oldCenter = pieceView.color == .white ? whitePieceCenter : blackPieceCenter
			finishMove = { self.addMovablePiece(color: pieceView.color) }
		}

		guard let newPosition = checkerboard.position(of: point) else {
			UIView.animate(withDuration: 0.3) {
				pieceView.layer.opacity = 0
				pieceView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
			} completion: { _ in
				finishMove()
				pieceView.removeFromSuperview()
			}
			return
		}

		guard newPosition.pieceView == nil else {
			UIView.animate(withDuration: 0.3) {
				pieceView.center = oldCenter
			}
			return
		}

		let newCenter = checkerboard.convert(newPosition.frame.center, to: view)
		UIView.animate(withDuration: 0.3) {
			pieceView.center = newCenter
		} completion: { _ in
			finishMove()
			newPosition.pieceView = pieceView
		}
	}
}
