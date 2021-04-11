//
//  ViewController.swift
//  Checkers
//
//  Created by Rustem on 06.04.2021.
//

import UIKit


struct InitialPosition {
    let circleView: CheckerView
    let frame: CGRect
}

class ViewController: UIViewController, CircleViewDelegate {
    
    private let colums = 4
    private let boardView = BoardView()
    private let circleView = CheckerView()
    private var drawed = false

    private var initialPositions: [InitialPosition] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        drawBoardView()
        
    }

    func drawCircles() {
        let height = boardView.frame.height / CGFloat(colums)
        let widht = boardView.frame.width / CGFloat(colums)
        for _ in 0..<colums {
            let frame = CGRect(x: view.center.x - 90, y: view.center.y + boardView.frame.height/2 + 50, width: widht, height: height)
            let circle = CheckerView(frame: frame)
            initialPositions.append(InitialPosition(circleView: circle, frame: frame))
            circle.drawCircle(black: true)
            circle.delegate = self
            view.addSubview(circle)
        }

        for _ in 0..<colums {
            let frame = CGRect(x: view.center.x, y: view.center.y + boardView.frame.height/2 + 50, width: widht, height: height)
            let circle = CheckerView(frame: frame)
            initialPositions.append(InitialPosition(circleView: circle, frame: frame))
            circle.drawCircle(black: false)
            circle.delegate = self
            view.addSubview(circle)
        }
    }
    
    override func viewDidLayoutSubviews() {
        if (!drawed){
            drawCircles()
            drawed = true
        }
    }

    func drawBoardView() {
        view.addSubview(boardView)
        boardView.set(colums: colums)
        boardView.layer.borderWidth = 4
        boardView.layer.borderColor = UIColor.black.cgColor

        boardView.translatesAutoresizingMaskIntoConstraints = false
        boardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        boardView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        boardView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        boardView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func setCenter(checkerView: CheckerView, point: CGPoint, initialPosition: CGPoint) {
        
        

        let pointBoard = view.convert(point, to: boardView)
        let pointBoard1 = view.convert(initialPosition, to: boardView)
        
        if !boardView.frame.contains(point) {
            UIView.animate(withDuration: 0.5) {
                checkerView.layer.opacity = 0
            } completion: { _ in
                checkerView.removeFromSuperview()
            }
            return
        }

         let newPosition = boardView.getTile(point: pointBoard)
        boardView.setFreeTile(point: pointBoard1)
        
        if newPosition.busy {
            print("busy")
            UIView.animate(withDuration: 0.5) { [self] in
                checkerView.center = initialPosition
               
            }
            return

        }


        let newCenter = boardView.convert(newPosition.frame.center, to: view)
        UIView.animate(withDuration: 0.5) {
            checkerView.center = newCenter
        } completion: { _ in
            newPosition.busy = true
        }
    }
}

extension CGRect {
    var center: CGPoint {
        CGPoint(x: (minX + maxX) / 2, y: (minY + maxY) / 2)
    }
}
