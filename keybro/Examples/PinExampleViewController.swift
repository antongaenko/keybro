//
//  PinExampleViewController.swift
//  keybro
//
//  Created by Anton Gaenko on 21.12.2020.
//

import UIKit

final class PinExampleViewController: LabeledController {

    private var pinLabel: UILabel { label }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reset()
        add(commands: [
            .digits { [weak self] digit in self?.enter(digit: digit) },
            .enter { [weak self] in self?.reset() }
        ])
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeAllCommands()
    }

    private func setup() {
        label.font = .monospacedSystemFont(ofSize: 32, weight: .thin)
        addLegend("Use digits (0..9) to enter pin code.\nPress Enter to reset.")
    }
}

extension PinExampleViewController {
    private func enter(digit: String) {
        if let text = pinLabel.text, let range = text.range(of: "_") {
            pinLabel.text = text.replacingCharacters(in: range, with: digit)
        }
    }

    private func reset() {
        pinLabel.text = "_ _ _ _ _ _"
    }
}
