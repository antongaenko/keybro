//
//  ScrollingExampleViewController.swift
//  keybro
//
//  Created by Anton Gaenko on 10.12.2020.
//

import UIKit

final class ScrollingExampleViewController: UITableViewController, ScrollCommandsProtocol {

    var scrollView: UIScrollView { tableView }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addScrollCommands()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeAllCommands()
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.contentInset = .init(top: 64, left: 0, bottom: 64, right: 0)
    }
}

extension ScrollingExampleViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        LegendLabel(text: "Use Space / Shift + Space to scroll forward/backward")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { fatalError("💁‍♂️") }
        cell.textLabel?.text = indexPath.description
        return cell
    }
}
