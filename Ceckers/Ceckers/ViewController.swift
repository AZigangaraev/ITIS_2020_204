//
//  ViewController.c++
//  КЕКЕРС - 0_0
//
//  Created by Никита Ляпустин on 04.04.2021.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		setup()
	}

	private var imageView: UIImageView?

	func setup() {
		let checkerField = CheckerFieldView()
		view.addSubview(checkerField)
		checkerField.awakeFromNib()
		checkerField.backgroundColor = .systemGray6
		checkerField.widthAnchor.constraint(equalToConstant: 200).isActive = true
		checkerField.heightAnchor.constraint(equalToConstant: 295).isActive = true
		checkerField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		checkerField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		checkerField.translatesAutoresizingMaskIntoConstraints = false
	}
}
