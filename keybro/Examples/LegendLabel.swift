//
//  LegendLabel.swift
//  keybro
//
//  Created by Anton Gaenko on 27.12.2020.
//

import UIKit

final class LegendLabel: UILabel {

    init(text: String) {
        super.init(frame: .zero)
        setup()
        self.text = text
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
        textAlignment = .center
        font = .systemFont(ofSize: 18)
    }
}
