//
//  ScrollCommandsProtocol.swift
//  keybro
//
//  Created by Anton Gaenko on 16.12.2020.
//

import UIKit

protocol ScrollCommandsProtocol: UIViewController {
    var scrollView: UIScrollView { get }

    func addScrollCommands()
}

extension ScrollCommandsProtocol {
    private var shiftY: CGFloat { scrollView.bounds.height / 2 }

    func addScrollCommands() {
        add(commands: [
            .space { [weak self] in self?.scrollForward() },
            .custom(input: Command.Key.space.rawValue, modifiers: [.shift]) { [weak self] in
                self?.scrollBackward() }
        ])
    }

    private func scrollForward() {
        let bottomContentInsets = scrollView.contentInset.bottom + scrollView.safeAreaInsets.bottom
        var newOffset = scrollView.contentOffset
        let minY = scrollView.contentSize.height - scrollView.bounds.height + bottomContentInsets
        newOffset.y = min(newOffset.y + shiftY, minY)
        scrollView.setContentOffset(newOffset, animated: true)
    }

    private func scrollBackward() {
        let topContentInsets = scrollView.contentInset.top + scrollView.safeAreaInsets.top
        var newOffset = scrollView.contentOffset
        newOffset.y = max(newOffset.y - shiftY, -topContentInsets)
        scrollView.setContentOffset(newOffset, animated: true)
    }
}
