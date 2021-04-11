//
//  CircleView.swift
//  Checkers
//
//  Created by Rishat on 04.04.2021.
//

import UIKit

enum Color {
    case white
    case black
}

protocol CircleViewDelegate: AnyObject {
    func movement(_ pieceView: CircleView, movedTo point: CGPoint)
}

class CircleView: UIImageView {
    var color: UIColor?
    weak var delegate: CircleViewDelegate?

    func setupCircle() {
        let render = UIGraphicsImageRenderer(size: CGSize(width: 75, height: 75))

        let img = render.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 75, height: 75).insetBy(dx: 5, dy: 5)

            let fillColor = color == .white ? UIColor.white.cgColor : UIColor.black.cgColor
            let strokeColor = color == .white ? UIColor.black.cgColor : UIColor.white.cgColor

            ctx.cgContext.setFillColor(fillColor)
            ctx.cgContext.setStrokeColor(strokeColor)
            ctx.cgContext.setLineWidth(2)

            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        image = img
    }

    func drawCircle() {
        isUserInteractionEnabled = true
        setupCircle()
        let tapGestureRecognizer = UIPanGestureRecognizer()
        tapGestureRecognizer.addTarget(self, action: #selector(handlePan(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }

    var initialPosition: CGPoint?

    @objc private func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began:
            initialPosition = gestureRecognizer.location(in: superview)
            superview?.bringSubviewToFront(self)
        case .changed:
            let translation = gestureRecognizer.translation(in: superview)
            center = CGPoint(x: initialPosition!.x + translation.x, y: initialPosition!.y + translation.y)
        case .ended:
            delegate?.movement(self, movedTo: center)
        default:
            break
        }
    }
}
