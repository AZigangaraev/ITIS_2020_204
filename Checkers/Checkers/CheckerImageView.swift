//
//  Checker.swift
//  Checkers
//
//  Created by Nikita Sosyuk on 04.04.2021.
//

import UIKit

class CheckerImageView: UIImageView {

    var type: CheckerType? {
        didSet {
            if type == .white {
                fillColor = #colorLiteral(red: 0.7969560027, green: 0.6842378974, blue: 0.5434461832, alpha: 1)
                borderColor = #colorLiteral(red: 0.5035105348, green: 0.4477041364, blue: 0.3504577279, alpha: 1)
            }
        }
    }
    var position: (Int, Int)?

    private var fillColor: UIColor = #colorLiteral(red: 0.3412892222, green: 0.1893915832, blue: 0.1615249813, alpha: 1)
    private var borderColor: UIColor = #colorLiteral(red: 0.1625680029, green: 0.05431050807, blue: 0.047333166, alpha: 1)

    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: self.frame.size)

        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 2, y: 2, width: self.frame.size.width - 4, height: self.frame.size.height - 4)

            ctx.cgContext.setFillColor(fillColor.cgColor)
            ctx.cgContext.setStrokeColor(borderColor.cgColor)
            ctx.cgContext.setLineWidth(2)

            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        self.image = img
    }

    func delete() {
        UIView.animate(withDuration: 0.5) {
            self.layer.opacity = 0
            self.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
}

enum CheckerType {
    case black
    case white
}
