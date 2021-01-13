//
//  ScenariosExampleViewController.swift
//  keybro
//
//  Created by Anton Gaenko on 21.12.2020.
//

import UIKit

final class ScenariosExampleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        add(commands: [
            .custom(input: "a", modifiers: .control) { [weak self] in self?.runScenario(name: "A") },
            .custom(input: "b", modifiers: .control) { [weak self] in self?.runScenario(name: "B") },
            .custom(input: "c", modifiers: .control) { [weak self] in self?.runScenario(name: "C") }
        ])
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeAllCommands()
    }

    private func setup() {
        view.backgroundColor = .white
        addLegend("Use ⌃a/⌃b/⌃c to run different scenarios")
    }
}

extension ScenariosExampleViewController {
    private func runScenario(name: String) {
        let controller = LabeledController(title: "Scenario \(name)\n\nPress Space/Enter/Backspace to dismiss")
        controller.modalPresentationStyle = .formSheet
        let dismiss: () -> Void = { [weak controller] in controller?.dismiss(animated: true, completion: nil) }
        controller.add(commands: [.space(dismiss), .enter(dismiss), .backspace(dismiss)])
        present(controller, animated: true, completion: nil)
    }
}
