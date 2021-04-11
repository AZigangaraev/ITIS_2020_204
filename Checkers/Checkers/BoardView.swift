//
//  CheckboardView.swift
//  Checkers
//
//  Created by Rustem on 06.04.2021.
//

import UIKit

class Tile {
    let frame: CGRect
    var busy: Bool!

    init(frame: CGRect, busy: Bool) {
        self.frame = frame
        self.busy = busy
    }
    
    init(frame: CGRect) {
        self.frame = frame
        self.busy = false
    }
}

class BoardView: UIImageView {
    
    func set(colums: Int) {
        self.backgroundColor = .white
        drawBoard(colums: colums)
    }
    
    var til: [Tile] = []

    func drawBoard(colums: Int) {
        let render = UIGraphicsImageRenderer(size: CGSize(width: 300, height: 300))

        let img = render.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            let size = 300/colums

            for x in 0..<colums {
                for y in 0..<colums {
                    let frame = CGRect(x: y * size, y: x * size, width: size, height: size)
                    if (x + y).isMultiple(of: 2)  {
                        ctx.cgContext.fill(frame)
                    }
                    til.append(Tile(frame: frame))
                }
            }
        }
        image = img
    }

    func getTile(point: CGPoint) -> Tile {
        var result:Tile!
        for position in til {
            if position.frame.contains(point) { result = position }
        }
        return result
    }
    
    func setFreeTile(point: CGPoint) {
        print("free")
        for position in til {
            
            if position.frame.contains(point) {
                print("free1")
                position.busy = false }
        }
    }

}
