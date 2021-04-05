//
//  ViewController.swift
//  Checkers
//
//  Created by Rishat on 04.04.2021.
//

import UIKit

struct InitialPosition {
    let circleView: CircleView
    let frame: CGRect
}

class ViewController: UIViewController, CircleViewDelegate {

    private let boardView = CheckboardView()
    private let circleView = CircleView()

    private var initialPositions: [InitialPosition] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        drawBoardView()
        drawCircles()
    }

    func drawCircles() {
        for i in 0..<4 {
            let frame = CGRect(x: i * 85 + 25, y: 500, width: 75, height: 75)
            let circle = CircleView(frame: frame)
            initialPositions.append(InitialPosition(circleView: circle, frame: frame))
            circle.color = .white
            circle.drawCircle()
            circle.initialPosition = circle.center
            circle.delegate = self
            view.addSubview(circle)
        }

        for i in 0..<4 {
            let frame = CGRect(x: i * 85 + 25, y: 580, width: 75, height: 75)
            let circle = CircleView(frame: frame)
            initialPositions.append(InitialPosition(circleView: circle, frame: frame))
            circle.color = .black
            circle.drawCircle()
            circle.initialPosition = circle.center
            circle.delegate = self
            view.addSubview(circle)
        }
    }

    func drawBoardView() {
        view.addSubview(boardView)
        boardView.drawCheckerboard()

        boardView.backgroundColor = .white
        boardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        boardView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        boardView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        boardView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        boardView.translatesAutoresizingMaskIntoConstraints = false
    }

    func movement(_ circleView: CircleView, movedTo point: CGPoint) {
        let point = view.convert(point, to: boardView)

        guard let newPosition = boardView.positionCell(of: point) else {
            UIView.animate(withDuration: 0.5) {
                circleView.layer.opacity = 0
            } completion: { _ in
                circleView.removeFromSuperview()
            }
            return
        }

        guard newPosition.circleView == nil else {
            UIView.animate(withDuration: 0.5) { [self] in
                if let oldPosition = boardView.positionCircle(of: circleView) {
                    circleView.center = boardView.convert(oldPosition.frame.center, to: view)
                } else {
                    for position in initialPositions {
                        if position.circleView == circleView {
                            circleView.center = position.frame.center
                            break
                        }
                    }
                }
            }
            return
        }

        let newCenter = boardView.convert(newPosition.frame.center, to: view)
        UIView.animate(withDuration: 0.5) {
            circleView.center = newCenter
        } completion: { _ in
            if let oldPosition = self.boardView.positionCircle(of: circleView) {
                oldPosition.circleView = nil
            }
            newPosition.circleView = circleView
        }
    }
}

extension CGRect {
    var center: CGPoint {
        CGPoint(x: (minX + maxX) / 2, y: (minY + maxY) / 2)
    }
}

