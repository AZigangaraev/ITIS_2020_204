//
//  ViewController.swift
//  HitTesting
//
//  Created by Amir Zigangaraev on 23.03.2021.
//

import UIKit

class MyViewWithButton: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setup()
    }

    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.frame = CGRect(x: 30, y: 30, width: 10, height: 10)
        return button
    }()

    private func setup() {
        backgroundColor = .yellow
        addSubview(button)
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
    }

    @objc private func buttonTap() {
        print("Button tap! \(Int.random(in: 1...100))")
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let buttonTouchFrame = button.frame.insetBy(dx: -15, dy: -15)
        if buttonTouchFrame.contains(point) {
            return button
        }
        return super.hitTest(point, with: event)
    }
}

class ExtendedButton: UIButton {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        bounds.insetBy(dx: -15, dy: -15).contains(point)
    }
}

class MyViewWithButton2: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setup()
    }

    private let button: UIButton = {
        let button = ExtendedButton()
        button.backgroundColor = .red
        button.frame = CGRect(x: 30, y: 30, width: 10, height: 10)
        return button
    }()

    private func setup() {
        backgroundColor = .yellow
        addSubview(button)
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
    }

    @objc private func buttonTap() {
        print("Button tap! \(Int.random(in: 1...100))")
    }
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(MyViewWithButton2(frame: CGRect(x: 20, y: 100, width: 100, height: 200)))
    }
}

