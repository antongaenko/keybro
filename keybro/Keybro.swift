//
//  Keybro.swift
//  keybro
//
//  Created by Anton Gaenko on 10.12.2020.
//

import UIKit

enum Command {
    typealias Action = () -> Void

    enum Key: String {
        case enter = "\r"
        case backspace = "\u{8}"
        case digits = "0123456789"
        case tab = "\t"
        case space = " "
    }

    case digits((String) -> Void)
    case enter(Action)
    case backspace(Action)
    case space(Action)
    case tab(Action)
    case custom(input: String, modifiers: UIKeyModifierFlags, action: Action)
}

extension UIViewController {
    private final class CommandsWrapper {
        let commands: [Command]

        init(commands: [Command]) {
            self.commands = commands
        }
    }

    static private var bindings = NSMapTable<UIViewController, CommandsWrapper>(keyOptions: .weakMemory)

    func add(command: Command) { add(commands: [command]) }

    func add(commands: [Command]) {
        guard !commands.isEmpty else { return }

        let existingCommands = Self.bindings.object(forKey: self)?.commands ?? []
        let allCommands = commands + existingCommands
        // we put custom commands at first place
        // it allows us to catch custom commands with modifiers before plain commands
        let sortedCommands = allCommands.sorted { left, right in
            if case .custom = left { return true }
            else { return false }
        }
        Self.bindings.setObject(.init(commands: sortedCommands), forKey: self)
        commands.flatMap(keyCommands).forEach(addKeyCommand)
    }

    func removeAllCommands() {
        Self.bindings.removeObject(forKey: self)
        keyCommands?.forEach(removeKeyCommand)
    }

    @objc fileprivate func didInput(keyCommand: UIKeyCommand) {
        guard let commands = Self.bindings.object(forKey: self)?.commands,
              let key = keyCommand.input
        else { return }

        for command in commands {
            if process(command, key: key, keyModifiers: keyCommand.modifierFlags) {
                break
            }
        }
    }

    private func keyCommands(from command: Command) -> [UIKeyCommand] {
        let action = #selector(UIViewController.didInput(keyCommand:))

        switch command {
        case .digits:
            return Array(Command.Key.digits.rawValue).map {
                .init(input: String($0), modifierFlags: [], action: action)
            }
        case .backspace:
            return [.init(input: Command.Key.backspace.rawValue, modifierFlags: [], action: action)]
        case .custom(let input, let modifiers, _):
            return [.init(input: input, modifierFlags: modifiers, action: action)]
        case .space:
            return [.init(input: Command.Key.space.rawValue, modifierFlags: [], action: action)]
        case .enter:
            return [.init(input: Command.Key.enter.rawValue, modifierFlags: [], action: action)]
        case .tab:
            return [.init(input: Command.Key.tab.rawValue, modifierFlags: [], action: action)]
        }
    }

    private func process(_ command: Command, key: String, keyModifiers: UIKeyModifierFlags) -> Bool {
        switch command {
        case .custom(let input , let modifiers, let action) where key == input && modifiers == keyModifiers:
            action()
            return true
        case .backspace(let action) where key == Command.Key.backspace.rawValue:
            action()
            return true
        case .enter(let action) where key == Command.Key.enter.rawValue:
            action()
            return true
        case .space(let action) where key == Command.Key.space.rawValue:
            action()
            return true
        case .tab(let action) where key == Command.Key.tab.rawValue:
            action()
            return true
        case .digits(let action) where Command.Key.digits.rawValue.contains(key):
            action(key)
            return true
        default : return false
        }
    }
}

extension UIViewController {
    func addDebug(command: Command) {
        #if DEBUG
        add(command: command)
        #endif
    }

    func addDebug(commands: [Command]) {
        #if DEBUG
        add(commands: commands)
        #endif
    }
}
