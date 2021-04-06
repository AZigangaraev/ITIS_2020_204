//
//  CircleView.swift
//  Checkers
//
//  Created by Rustem on 06.04.2021.
//

import UIKit

protocol CircleViewDelegate: AnyObject {
    func setCenter(checkerView: CheckerView, point: CGPoint, initialPosition: CGPoint)
}

class CheckerView: UIView {
    private var color: CGColor!
    private var color1: CGColor!
    weak var delegate: CircleViewDelegate?
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.setFillColor(color)
        context.setStrokeColor(color1)
        context.setLineWidth(4)
        context.addEllipse(in: bounds.insetBy(dx: 4, dy: 4))
        context.drawPath(using: .fillStroke)
    }

    func drawCircle(black: Bool) {
        if black {
            self.color = UIColor.black.cgColor
            self.color1 = UIColor.white.cgColor
        } else {
            self.color = UIColor.white.cgColor
            self.color1 = UIColor.black.cgColor
        }
        
        initialPosition = self.center
        backgroundColor = .clear
        isUserInteractionEnabled = true
        let tapGestureRecognizer = UIPanGestureRecognizer()
        tapGestureRecognizer.addTarget(self, action: #selector(handlePan(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }

    var initialPosition: CGPoint?
    var firstPosition: CGPoint?

    @objc private func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began:
            firstPosition = self.initialPosition
            
            print(firstPosition)
            initialPosition = gestureRecognizer.location(in: self)
           
            superview?.bringSubviewToFront(self)
        case .changed:
            self.frame.origin = gestureRecognizer.location(in: superview)
                .applying(
                    CGAffineTransform(
                        translationX: -(initialPosition?.x ?? 0),
                        y: -(initialPosition?.y ?? 0)
                    )
                )
        case .ended:
            delegate?.setCenter(checkerView: self, point: center, initialPosition: firstPosition!)
            firstPosition = self.frame.center

            
        default:
            break
        }
    }
}
