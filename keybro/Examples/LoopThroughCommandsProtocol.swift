//
//  LoopThroughCommandsProtocol.swift
//  keybro
//
//  Created by Anton Gaenko on 16.12.2020.
//

import UIKit

protocol LoopThroughCommandsProtocol: UIViewController {
    var currentControl: UIControl? { get set }

    func addLoopThroughCommands()
}

extension LoopThroughCommandsProtocol {
    func addLoopThroughCommands() {
        add(commands: [
            .tab { [weak self] in self?.selectNextControl() },
            .enter { [weak self] in self?.currentControl?.sendActions(for: .touchUpInside) }
        ])
    }

    private func selectNextControl() {
        let allControls = view.allControls
        currentControl?.isSelected = false
        if let currentControl = currentControl,
           let index = allControls.firstIndex(of: currentControl),
           index + 1 < allControls.count {
            self.currentControl = allControls[index + 1]
        } else {
            currentControl = allControls.first
        }
        currentControl?.isSelected = true
    }
}

extension UIView {
    var allSubviews: [UIView] { subviews.flatMap { [$0] + $0.allSubviews } }

    var allControls: [UIControl] { allSubviews.compactMap { $0 as? UIControl } }
}
