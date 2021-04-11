//
//  BoardView.swift
//  CheckersApp
//
//  Created by galiev nail on 06.04.2021.
//

import Foundation
import UIKit

class CheckerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //        setup()
    }

    func setup(with count: Int) {
        let blackPath = UIBezierPath()
        let whitePath = UIBezierPath()
        var ellipsePath = UIBezierPath()
        let x = 105
        let y = 105
        var t = 0
        while t < count {
            if t % 2 == 0 {
                blackPath.move(to: CGPoint(x: x * t, y: 550 - y))
                blackPath.addLine(to: CGPoint(x: x * t, y: 450 - y))
                blackPath.addLine(to: CGPoint(x: 105 + x * t, y: 450 - y))
                blackPath.addLine(to: CGPoint(x: 105 + x * t, y: 550 - y))
                blackPath.close()
//                ellipsePath = UIBezierPath(ovalIn: CGRect(x: 25, y: 475 - y, width: 50, height: 50))
//
                whitePath.move(to: CGPoint(x: x * t, y: 450 - y))
                whitePath.addLine(to: CGPoint(x: x * t, y: 350 - y))
                whitePath.addLine(to: CGPoint(x: 105 + x * t, y: 350 - y))
                whitePath.addLine(to: CGPoint(x: 105 + x * t, y: 450 - y))
                whitePath.close()
                
                blackPath.move(to: CGPoint(x: x * t, y: 350 - y))
                blackPath.addLine(to: CGPoint(x: x * t, y: 250 - y))
                blackPath.addLine(to: CGPoint(x: 105 + x * t, y: 250 - y))
                blackPath.addLine(to: CGPoint(x: 105 + x * t, y: 350 - y))
                blackPath.close()
                
                whitePath.move(to: CGPoint(x: x * t, y: 250 - y))
                whitePath.addLine(to: CGPoint(x: x * t, y: 150 - y))
                whitePath.addLine(to: CGPoint(x: 105 + x * t, y: 150 - y))
                whitePath.addLine(to: CGPoint(x: 105 + x * t, y: 250 - y))
                whitePath.close()
                
            } else {
                whitePath.move(to: CGPoint(x: x * t, y: 550 - y))
                whitePath.addLine(to: CGPoint(x: x * t, y: 450 - y))
                whitePath.addLine(to: CGPoint(x: 105 + x * t, y: 450 - y))
                whitePath.addLine(to: CGPoint(x: 105 + x * t, y: 550 - y))
                whitePath.close()
                
                blackPath.move(to: CGPoint(x: x * t, y: 450 - y))
                blackPath.addLine(to: CGPoint(x: x * t, y: 350 - y))
                blackPath.addLine(to: CGPoint(x: 105 + x * t, y: 350 - y))
                blackPath.addLine(to: CGPoint(x: 105 + x * t, y: 550 - y))
                blackPath.close()
                
                whitePath.move(to: CGPoint(x: x * t, y: 350 - y))
                whitePath.addLine(to: CGPoint(x: x * t, y: 250 - y))
                whitePath.addLine(to: CGPoint(x: 105 + x * t, y: 250 - y))
                whitePath.addLine(to: CGPoint(x: 105 + x * t, y: 350 - y))
                whitePath.close()
                
                blackPath.move(to: CGPoint(x: x * t, y: 250 - y))
                blackPath.addLine(to: CGPoint(x: x * t, y: 150 - y))
                blackPath.addLine(to: CGPoint(x: 105 + x * t, y: 150 - y))
                blackPath.addLine(to: CGPoint(x: 105 + x * t, y: 250 - y))
                blackPath.close()
            }
            t += 1
        }
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = ellipsePath.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 5.0
        let blackLayer = CAShapeLayer()
        let whiteLayer = CAShapeLayer()
        let whiteCg = whitePath.cgPath
        let cgPath = blackPath.cgPath
        blackLayer.fillColor = UIColor.black.cgColor
        whiteLayer.fillColor = UIColor.white.cgColor
        blackLayer.path = cgPath
        whiteLayer.path = whiteCg
        self.layer.addSublayer(blackLayer)
        self.layer.addSublayer(whiteLayer)
        self.layer.addSublayer(shapeLayer)
        
    }
    
}
