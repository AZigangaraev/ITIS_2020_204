//
//  GameField.swift
//  Checkers
//
//  Created by Nikita Sosyuk on 04.04.2021.
//

import UIKit

class GameFieldView: UIView {

    var isFigure: [[Bool]] = {
        var boolArray = [[Bool]]()
        for i in 0...3 {
            boolArray.append([])
            for _ in 0...3 {
                boolArray[i].append(true)
            }
        }
        return boolArray
    }()

    func drawField() {
        let frameSize = frame.size
        let width = frameSize.width / 4
        var xPosition: CGFloat = width
        var yPosition: CGFloat = 0
        let bezierPath = UIBezierPath()
        for i in 0...3 {
            for _ in 0...1 {
                bezierPath.usesEvenOddFillRule = true
                bezierPath.move(to: CGPoint(x: xPosition, y: yPosition))
                xPosition += width
                bezierPath.addLine(to: CGPoint(x: xPosition, y: yPosition))
                yPosition += width
                bezierPath.addLine(to: CGPoint(x: xPosition, y: yPosition))
                xPosition -= width
                bezierPath.addLine(to: CGPoint(x: xPosition, y: yPosition))
                bezierPath.close()
                yPosition -= width
                xPosition += 2 * width
            }
            if i % 2 == 0 {
                xPosition = 0
            } else {
                xPosition = width
            }
            yPosition += width
        }
        let cgPath = bezierPath.cgPath
        let layer = CAShapeLayer()
        layer.path = cgPath
        layer.fillColor = #colorLiteral(red: 0.189373225, green: 0.18376261, blue: 0.2056661546, alpha: 1).cgColor
        self.layer.addSublayer(layer)
    }

    func getPoint(for checker: CheckerImageView, at point: CGPoint) -> CGPoint {
        var xPosition: CGFloat = 0
        var yPosition: CGFloat = 0
        let width = self.frame.size.width / 4
        let halfWidth = width / 2
        if let index = checker.position {
            isFigure[index.0][index.1] = true
        }
        for i in 0...3 {
            for j in 0...3 {
                if xPosition <= point.x, point.x < xPosition + width, yPosition <= point.y, point.y < yPosition + width {
                    if isFigure[i][j] {
                        checker.position = (i, j)
                        isFigure[i][j] = false
                        return CGPoint(x: xPosition + halfWidth, y: yPosition + halfWidth)
                    } else {
                        if let index = checker.position {
                            isFigure[index.0][index.1] = false
                            return CGPoint(x: CGFloat(index.1) * width + halfWidth , y: halfWidth + CGFloat(index.0) * width)
                        }
                        return CGPoint(x: 0, y: 0)
                    }
                }
                xPosition += width
            }
            xPosition = 0
            yPosition += width
        }
        return CGPoint(x: 0, y: 0)
    }
}
