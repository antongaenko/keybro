//
//  AnimationExampleViewController.swift
//  keybro
//
//  Created by Anton Gaenko on 07.02.2021.
//

import UIKit

final class AnimationExampleViewController: UIViewController {

    private lazy var redView: UIView = {
        let view = UIView(frame: self.view.bounds.insetBy(dx: 100, dy: 150))
        view.backgroundColor = .systemRed
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        add(commands: [
            .custom(input: "t", modifiers: [.control]) { [weak self] in
                self?.view.window?.toggleSlowAnimation()
            },
            .custom(input: "d", modifiers: [.control]) { [weak self] in
                self?.showDebugMenu()
            }
        ])
        redView.layer.add(makeRotationAnimation(), forKey: "rotate")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeAllCommands()
        redView.layer.removeAllAnimations()
    }

    private func setup() {
        view.backgroundColor = .white

        addLegend("Press ^T to slow down animation\nPress ^D to show debug menu")

        view.addSubview(redView)
    }

    private func makeRotationAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.transform))
        animation.fromValue = CATransform3DIdentity
        animation.duration = 1
        animation.toValue = CATransform3DMakeRotation(.pi, 0, 0, 1)
        animation.repeatCount = .greatestFiniteMagnitude
        return animation
    }

    private func showDebugMenu() {
        let actionSheetController = UIAlertController(title: "Debug menu", message: nil, preferredStyle: .actionSheet)
        actionSheetController.addAction(.init(title: "Toggle slow animation",
                                             style: .default,
                                             handler: { [weak self] _ in
                                                self?.view.window?.toggleSlowAnimation()
                                             }))
        actionSheetController.add(commands: [
            .enter { [weak actionSheetController, weak self] in
                self?.view.window?.toggleSlowAnimation()
                actionSheetController?.dismiss(animated: true, completion: nil)
            }
        ])
        actionSheetController.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheetController, animated: true, completion: nil)
    }
}

extension UIWindow {
    func toggleSlowAnimation() {
        let wasNormalSpeed = layer.speed >= 1 - .ulpOfOne
        layer.timeOffset = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.beginTime = CACurrentMediaTime()
        layer.speed = wasNormalSpeed ? 0.1 : 1
    }
}
