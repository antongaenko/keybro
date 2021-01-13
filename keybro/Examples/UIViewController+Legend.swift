//
//  UIViewController+Legend.swift
//  keybro
//
//  Created by Anton Gaenko on 27.12.2020.
//

import UIKit

extension UIViewController {
    enum Anchor {
        case top
        case tabBar
    }

    func addLegend(_ text: String, anchor: Anchor = .top) {
        let legendLabel = LegendLabel(text: text)

        if anchor == .top {
            view.addSubview(legendLabel)
            NSLayoutConstraint.activate([
                legendLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
                legendLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        } else if anchor == .tabBar, let tabBar = tabBarController?.tabBar {
            tabBar.addSubview(legendLabel)
            NSLayoutConstraint.activate([
                legendLabel.bottomAnchor.constraint(equalTo: tabBar.safeAreaLayoutGuide.topAnchor, constant: -24),
                legendLabel.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor)
            ])
        }
    }
}
