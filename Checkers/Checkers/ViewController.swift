//
//  ViewController.swift
//  Checkers
//
//  Created by Nikita Sosyuk on 04.04.2021.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    private var arrayOfCheckers = [CheckerImageView]()
    private var gameFieldView = GameFieldView(frame: CGRect(x: UIScreen.main.bounds.width * 0.2 / 2, y: (UIScreen.main.bounds.height - UIScreen.main.bounds.width * 0.8) / 2, width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8))
    private var initialPosition: CGPoint?
    private lazy var safeAreaTop: CGFloat = 40
    private let gameFieldWidth = UIScreen.main.bounds.width * 0.75
    private let distanceBetweenCheckers: CGFloat = 10

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(gameFieldView)
        gameFieldView.drawField()
        gameFieldView.backgroundColor = #colorLiteral(red: 0.7950325608, green: 0.72426337, blue: 0.6458325982, alpha: 1)
        setCheckersArray()
    }

    // MARK: - Private Methods
    private func setCheckersArray() {
        let width = gameFieldWidth / 4
        var xStart = (gameFieldWidth - width) / 2
        for _ in 0...3 {
            let checker = CheckerImageView(frame: CGRect(x: xStart, y: safeAreaTop, width: width, height: width))
            checker.type = .white
            checker.drawCircle()
            checker.isUserInteractionEnabled = true
            arrayOfCheckers.append(checker)
            view.addSubview(checker)
        }
        xStart += width + distanceBetweenCheckers
        for _ in 0...3 {
            let checker = CheckerImageView(frame: CGRect(x: xStart, y: safeAreaTop, width: width, height: width))
            checker.type = .black
            checker.drawCircle()
            checker.isUserInteractionEnabled = true
            arrayOfCheckers.append(checker)
            view.addSubview(checker)
        }
        addTapGestureRecognizers()
    }

    private func recognizeAction(gestureRecognizer: UITapGestureRecognizer, checker: CheckerImageView) {
        switch gestureRecognizer.state {
        case .began:
            initialPosition = gestureRecognizer.location(in: checker)
        case .changed:
            checker.frame.origin = gestureRecognizer.location(in: view)
                .applying(
                    CGAffineTransform(
                        translationX: -(initialPosition?.x ?? 0),
                        y: -(initialPosition?.y ?? 0)
                    )
                )
        case .ended:
            endedGesture(checker: checker)
        default:
            break
        }
    }

    private func endedGesture(checker: CheckerImageView) {
        var point = checker.center
        point.x -= gameFieldView.frame.minX
        point.y -= gameFieldView.frame.minY
        if gameFieldView.point(inside: point, with: nil) {
            var newPoint = gameFieldView.getPoint(for: checker, at: point)
            if newPoint.x == 0, newPoint.y == 0, let type = checker.type {
                switch type {
                case .white :
                    newPoint = CGPoint(x: (gameFieldWidth - checker.frame.width) / 2, y: safeAreaTop)
                default:
                    newPoint = CGPoint(x: (gameFieldWidth + checker.frame.width) / 2 + distanceBetweenCheckers, y: safeAreaTop)
                }
                UIView.animate(withDuration: 0.5) {
                    checker.frame.origin = newPoint
                }
            } else {
                newPoint.x += gameFieldView.frame.minX
                newPoint.y += gameFieldView.frame.minY
                UIView.animate(withDuration: 0.5) {
                    checker.center = newPoint
                }
            }
        } else {
            checker.delete()
        }
    }

    // MARK - GestRecognizers (Trash)
    private func addTapGestureRecognizers() {
        let tapGestureRecognizerOne = UIPanGestureRecognizer()
        tapGestureRecognizerOne.addTarget(self, action: #selector(handlePanOne(_:)))
        arrayOfCheckers[0].addGestureRecognizer(tapGestureRecognizerOne)

        let tapGestureRecognizerTwo = UIPanGestureRecognizer()
        tapGestureRecognizerTwo.addTarget(self, action: #selector(handlePanTwo(_:)))
        arrayOfCheckers[1].addGestureRecognizer(tapGestureRecognizerTwo)

        let tapGestureRecognizerThree = UIPanGestureRecognizer()
        tapGestureRecognizerThree.addTarget(self, action: #selector(handlePanThree(_:)))
        arrayOfCheckers[2].addGestureRecognizer(tapGestureRecognizerThree)

        let tapGestureRecognizerFour = UIPanGestureRecognizer()
        tapGestureRecognizerFour.addTarget(self, action: #selector(handlePanFour(_:)))
        arrayOfCheckers[3].addGestureRecognizer(tapGestureRecognizerFour)

        let tapGestureRecognizerFive = UIPanGestureRecognizer()
        tapGestureRecognizerFive.addTarget(self, action: #selector(handlePanFive(_:)))
        arrayOfCheckers[4].addGestureRecognizer(tapGestureRecognizerFive)

        let tapGestureRecognizerSix = UIPanGestureRecognizer()
        tapGestureRecognizerSix.addTarget(self, action: #selector(handlePanSix(_:)))
        arrayOfCheckers[5].addGestureRecognizer(tapGestureRecognizerSix)

        let tapGestureRecognizerSeven = UIPanGestureRecognizer()
        tapGestureRecognizerSeven.addTarget(self, action: #selector(handlePanSeven(_:)))
        arrayOfCheckers[6].addGestureRecognizer(tapGestureRecognizerSeven)

        let tapGestureRecognizerEight = UIPanGestureRecognizer()
        tapGestureRecognizerEight.addTarget(self, action: #selector(handlePanEight(_:)))
        arrayOfCheckers[7].addGestureRecognizer(tapGestureRecognizerEight)
    }

    @objc private func handlePanOne(_ gestureRecognizer: UITapGestureRecognizer) {
        recognizeAction(gestureRecognizer: gestureRecognizer, checker: arrayOfCheckers[0])
    }

    @objc private func handlePanTwo(_ gestureRecognizer: UITapGestureRecognizer) {
        recognizeAction(gestureRecognizer: gestureRecognizer, checker: arrayOfCheckers[1])
    }

    @objc private func handlePanThree(_ gestureRecognizer: UITapGestureRecognizer) {
        recognizeAction(gestureRecognizer: gestureRecognizer, checker: arrayOfCheckers[2])
    }

    @objc private func handlePanFour(_ gestureRecognizer: UITapGestureRecognizer) {
        recognizeAction(gestureRecognizer: gestureRecognizer, checker: arrayOfCheckers[3])
    }

    @objc private func handlePanFive(_ gestureRecognizer: UITapGestureRecognizer) {
        recognizeAction(gestureRecognizer: gestureRecognizer, checker: arrayOfCheckers[4])
    }

    @objc private func handlePanSix(_ gestureRecognizer: UITapGestureRecognizer) {
        recognizeAction(gestureRecognizer: gestureRecognizer, checker: arrayOfCheckers[5])
    }

    @objc private func handlePanSeven(_ gestureRecognizer: UITapGestureRecognizer) {
        recognizeAction(gestureRecognizer: gestureRecognizer, checker: arrayOfCheckers[6])
    }

    @objc private func handlePanEight(_ gestureRecognizer: UITapGestureRecognizer) {
        recognizeAction(gestureRecognizer: gestureRecognizer, checker: arrayOfCheckers[7])
    }
}
