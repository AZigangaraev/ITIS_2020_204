//
//  ViewController.swift
//  CheckersApp
//
//  Created by galiev nail on 05.04.2021.
//

import UIKit

class ViewController: UIViewController {
    let triangle = CheckerView()
    let piece = PieceView(color: .black)
    override func viewDidLoad() {
        super.viewDidLoad()
        triangle.setup(with: 4)
        view.addSubview(triangle)
        view.addSubview(piece)
    }
}

