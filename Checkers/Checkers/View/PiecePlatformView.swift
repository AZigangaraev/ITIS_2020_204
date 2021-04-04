//
//  PiecePlatform.swift
//  Checkers
//
//  Created by Robert Mukhtarov on 04.04.2021.
//

import UIKit

class PiecePlatformView: UIStackView {
	let blackPiece = PieceView(color: .black)
	let whitePiece = PieceView(color: .white)
	
	init() {
		super.init(frame: CGRect(x: 0, y: 0, width: 150, height: 70))
		setup()
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setup() {
		whitePiece.isUserInteractionEnabled = false
		blackPiece.isUserInteractionEnabled = false
		distribution = .equalSpacing
		axis = .horizontal
		addArrangedSubview(whitePiece)
		addArrangedSubview(blackPiece)
		layoutIfNeeded()
	}
}
