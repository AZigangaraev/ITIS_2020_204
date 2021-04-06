//
//  PieceView.swift
//  CheckersApp
//
//  Created by galiev nail on 06.04.2021.
//

import Foundation
import UIKit

class PieceView: UIView {
    let color: PieceColor
    private var initialPosition = CGPoint(x: 0, y: 0)
    
    init(color: PieceColor) {
        self.color = color
        super.init(frame: CGRect(x: 300, y: 700, width: 70, height: 70))
        backgroundColor = .clear
        clipsToBounds = false
        gestureRecognizers = [UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let fillColor = color == .white ? UIColor.systemGray6.cgColor : UIColor.systemGray.cgColor
        let strokeColor = color == .white ? UIColor.systemGray4.cgColor : UIColor.darkGray.cgColor
        
        context.setFillColor(fillColor)
        context.setStrokeColor(strokeColor)
        context.setLineWidth(5)
        context.addEllipse(in: bounds.insetBy(dx: 3, dy: 3))
        context.drawPath(using: .fillStroke)
    }
    
    @objc private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            initialPosition = recognizer.location(in: superview)
            superview?.bringSubviewToFront(self)
        case .changed:
            let translation = recognizer.translation(in: superview)
            center = CGPoint(x: initialPosition.x + translation.x, y: initialPosition.y + translation.y)
        case .ended:
            if center.x < 20 {
                UIView.animate(withDuration: 0.2, animations: { [unowned self] in
                    self.center.x = -(self.superview?.frame.size.width ?? 0)
                })
                UIView.animate(withDuration: 0, delay: 1, options: [], animations: {
                    self.center = CGPoint(x: 200, y: 700)
                })
            } else if center.x > (self.superview?.frame.size.width)! - 5{
                UIView.animate(withDuration: 0.2, animations: { [unowned self] in
                    self.center.x = 100 + (self.superview?.frame.size.width)!
                })
                UIView.animate(withDuration: 0, delay: 1, options: [], animations: {
                    self.center = CGPoint(x: 200, y: 700)
                })
            }
        default:
            break
        }
    }
}

enum PieceColor {
    case white
    case black
}
