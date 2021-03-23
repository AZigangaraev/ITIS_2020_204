//
//  ViewController.swift
//  Gestures
//
//  Created by Amir Zigangaraev on 23.03.2021.
//

import UIKit

class ViewController: UIViewController {
    let draggableView: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
        view.backgroundColor = .red
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(draggableView)
        let tapGestureRecognizer = UIPanGestureRecognizer()
        tapGestureRecognizer.addTarget(self, action: #selector(handlePan(_:)))
        draggableView.addGestureRecognizer(tapGestureRecognizer)
    }

    private var initialPosition: CGPoint?

    @objc private func handlePan(_ gestureRecognizer: UITapGestureRecognizer) {
        switch gestureRecognizer.state {
            case .began:
                initialPosition = gestureRecognizer.location(in: draggableView)
            case .changed:
                draggableView.frame.origin = gestureRecognizer.location(in: view)
                    .applying(
                        CGAffineTransform(
                            translationX: -(initialPosition?.x ?? 0),
                            y: -(initialPosition?.y ?? 0)
                        )
                    )
            default:
                break
        }
    }
}

