//
//  ExampleViewController.swift
//  keybro
//
//  Created by Anton Gaenko on 10.12.2020.
//

import UIKit

final class LoopThroughExampleViewController: UIViewController {

    private let stackView = UIStackView()
    private var currentControl: UIControl?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupStackView()
        addButtonsToStack()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addLoopThroughCommands()
        add(commands: [
            .custom(input: "=", modifiers: []) { [weak self] in self?.zoomIn() },
            .custom(input: "-", modifiers: []) { [weak self] in self?.zoomOut() }
        ])
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeAllCommands()
    }

    private func setupStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        stackView.axis = .vertical
    }

    private func addButtonsToStack() {
        let buttons = (1...7).map { index in
            UIButton(primaryAction: .init(title: index.description, handler: { _ in
                print(index.description)
            }))
        }
        buttons.forEach(stackView.addArrangedSubview)
    }

    private func zoomIn() {
        UIView.animate(withDuration: 0.3) {
            self.view.window?.transform = .init(scaleX: 3, y: 3)
        }
    }

    private func zoomOut() {
        UIView.animate(withDuration: 0.3) {
            self.view.window?.transform = .identity
        }
    }
}
