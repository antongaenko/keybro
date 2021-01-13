//
//  AppDelegate.swift
//  keybro
//
//  Created by Anton Gaenko on 16.12.2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private lazy var navigationController: UINavigationController = {
        let controller = LoopThroughExampleViewController()
        controller.title = "Use arrows ◀︎ ▶︎ for push/pop demo"
        return UINavigationController(rootViewController: controller)
    }()

    private lazy var tabBarController: UITabBarController = { UITabBarController() }()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

        setupNavigationController()
        setupTabBarController()

        inject()

        return true
    }

    private func setupTabBarController() {
        let appearance = UITabBarItem.appearance()
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 32)]
        appearance.setTitleTextAttributes(attributes, for: .normal)

        let scrollingController = ScrollingExampleViewController(style: .grouped)
        scrollingController.tabBarItem = .init(title: "⌃2", image: nil, tag: 1)
        let pinController = PinExampleViewController()
        pinController.tabBarItem = .init(title: "⌃3", image: nil, tag: 1)
        let scenariosController = ScenariosExampleViewController()
        scenariosController.tabBarItem = .init(title: "⌃4", image: nil, tag: 1)
        tabBarController.viewControllers = [
            navigationController, scrollingController, pinController, scenariosController
        ]
        navigationController.addLegend("Use ⌃1/2/3/4 to switch tabs", anchor: .tabBar)
        addTabBarControllerCommands()
    }

    private func setupNavigationController() {
        navigationController.tabBarItem = .init(title: "⌃1", image: UIImage(), tag: 0)
        addNavigationControllerCommands()
    }

    private func inject() {
        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
    }

    private func reloadExampleController() {
        navigationController.pushViewController(LoopThroughExampleViewController(), animated: true)
    }

    private func addNavigationControllerCommands() {
        navigationController.add(commands: [
            .custom(input: UIKeyCommand.inputRightArrow, modifiers: [], action: { [weak navigationController] in
                navigationController?.pushViewController(LoopThroughExampleViewController(), animated: true)
            }),
            .custom(input: UIKeyCommand.inputLeftArrow, modifiers: [], action: { [weak navigationController] in
                navigationController?.popViewController(animated: true)
            })
        ])
    }

    private func addTabBarControllerCommands() {
        tabBarController.add(commands: [
            .custom(input: "1", modifiers: .control, action: { [weak tabBarController] in
                tabBarController?.selectedIndex = 0
            }),
            .custom(input: "2", modifiers: .control, action: { [weak tabBarController] in
                tabBarController?.selectedIndex = 1
            }),
            .custom(input: "3", modifiers: .control, action: { [weak tabBarController] in
                tabBarController?.selectedIndex = 2
            }),
            .custom(input: "4", modifiers: .control, action: { [weak tabBarController] in
                tabBarController?.selectedIndex = 3
            })
        ])
    }
}
