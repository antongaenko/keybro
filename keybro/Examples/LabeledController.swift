//
//  LabeledController.swift
//  keybro
//
//  Created by Anton Gaenko on 22.12.2020.
//

import UIKit

class LabeledController: UIViewController {

    let label = UILabel()

    convenience init() {
        self.init(title: "")
    }

    init(title: String) {
        label.text = title
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        view.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24)
        view.addSubview(label)
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: label.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            label.leftAnchor.constraint(greaterThanOrEqualTo: view.leftAnchor, constant: 16),
            label.rightAnchor.constraint(greaterThanOrEqualTo: view.rightAnchor, constant: -16),
        ])
    }
}
