//
//  ExampleViewController.swift
//  keybro
//
//  Created by Anton Gaenko on 10.12.2020.
//

import UIKit

final class LoopThroughExampleViewController: UIViewController, LoopThroughCommandsProtocol {

    private let stackView = UIStackView()
    var currentControl: UIControl?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupStackView()
        addButtonsToStack()
        setupLegend()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addZoomCommands()
        addLoopThroughCommands()
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
            UIButton(primaryAction: .init(title: "Show \"\(index)\"", handler: { [weak self] _ in
                self?.showAlert(index.description)
            }))
        }
        buttons.forEach(stackView.addArrangedSubview)
    }

    private func setupLegend() {
        let legend = """
            Use Tab to loop through controls,\n\
            press Enter to call main action. \n\
            Use -/= for zooming.
        """
        addLegend(legend)
    }

    private func showAlert(_ title: String) {
        let alertController = UIAlertController(title: title,
                                                message: "Press Enter/Space/Tab to dismiss",
                                                preferredStyle: .alert)
        let dismiss: () -> Void = { [weak alertController] in
            alertController?.dismiss(animated: true, completion: nil)
        }
        alertController.add(commands: [.enter(dismiss), .space(dismiss), .tab(dismiss)])
        present(alertController, animated: true, completion: nil)
    }
}

extension LoopThroughExampleViewController {
    private func addZoomCommands() {
        add(commands: [
            .custom(input: "=", modifiers: []) { [weak self] in self?.zoomIn() },
            .custom(input: "-", modifiers: []) { [weak self] in self?.zoomOut() }
        ])
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
