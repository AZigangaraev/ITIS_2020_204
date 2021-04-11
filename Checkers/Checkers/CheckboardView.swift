//
//  CheckboardView.swift
//  Checkers
//
//  Created by Rishat on 04.04.2021.
//

import UIKit

class Position {
    let frame: CGRect
    var circleView: CircleView?

    init(frame: CGRect, circleView: CircleView? = nil) {
        self.frame = frame
        self.circleView = circleView
    }
}

class CheckboardView: UIImageView {
    var positions: [Position] = []

    func drawCheckerboard() {
        let render = UIGraphicsImageRenderer(size: CGSize(width: 300, height: 300))

        let img = render.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)

            for x in 0 ..< 4 {
                for y in 0 ..< 4 {
                    let frame = CGRect(x: y * 75, y: x * 75, width: 75, height: 75)
                    positions.append(Position(frame: frame))
                    if (x + y).isMultiple(of: 2)  {
                        ctx.cgContext.fill(frame)
                    }
                }
            }
        }
        image = img
    }

    func positionCell(of point: CGPoint) -> Position? {
        for position in positions {
            if position.frame.contains(point) { return position }
        }
        return nil
    }

    func positionCircle(of circleView: CircleView) -> Position? {
        for position in positions {
            if position.circleView == circleView { return position }
        }
        return nil
    }
}
