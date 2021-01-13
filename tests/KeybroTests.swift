//
//  KeybroTests.swift
//
//  Created by Anton Gaenko on 07.01.2021.
//

import XCTest

final class KeybroTests: XCTestCase {

    private var controller: UIViewController!
    private var wasCalled: Bool = false

    override func setUp() {
        controller = UIViewController()
    }

    override func tearDown() {
        wasCalled = false
        controller.removeAllCommands()
    }

    func test_addAndCall_digits_command() {
        controller.add(command: .digits { [weak self] _ in self?.wasCalled = true })
        for character in Command.Key.digits.rawValue {
            assertInput(String(character))
        }
        callCommand(for: "1")
        XCTAssertTrue(wasCalled)
    }

    func test_addAndCall_enter_command() {
        assertAddAndCall(command: .enter(markCalled), for: .enter)
    }

    func test_addAndCall_backspace_command() {
        assertAddAndCall(command: .backspace(markCalled), for: .backspace)
    }

    func test_addAndCall_space_command() {
        assertAddAndCall(command: .space(markCalled), for: .space)
    }

    func test_addAndCall_tab_command() {
        assertAddAndCall(command: .tab(markCalled), for: .tab)
    }

    func test_addAndCall_custom_command() {
        controller.add(command: .custom(input: "n", modifiers: .command, action: markCalled))
        assertInput("n")
        callCommand(for: "n")
        XCTAssertTrue(wasCalled)
    }
    
    func test_remove_commands() {
        controller.add(commands: [.enter({}), .backspace({}), .tab({})])
        XCTAssertEqual(controller.keyCommands?.count, 3)
        controller.removeAllCommands()
        XCTAssertEqual(controller.keyCommands?.count, 0)
    }
}

extension KeybroTests {

    private func assertAddAndCall(command: Command, for key: Command.Key) {
        controller.add(command: command)
        assertInput(key)
        callCommand(for: key.rawValue)
        XCTAssertTrue(wasCalled)
    }

    private func assertInput(_ input: Command.Key) {
        assertInput(input.rawValue)
    }

    private func assertInput(_ input: String) {
        XCTAssertEqual(controller.keyCommands?.contains { $0.input == input }, true)
    }

    private func callCommand(for input: String) {
        guard let command = controller.keyCommands?.first(where: { $0.input == input }) else {
            XCTFail("No command for \(input)")
            return
        }
        controller.perform(command.action, with: command)
    }

    private func markCalled() { wasCalled = true }
}
