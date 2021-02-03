![build&test](https://github.com/antongaenko/keybro/workflows/bro%20workflow/badge.svg?branch=main)

# Keybro

## What is it? 

It's a wrapper for `UIKeyCommand` which allows you to easily create keyboard shortcuts for your iOS app. It can speed up development and manual testing apps in simulator. This micro lib contains one file and only [120 lines of code](https://github.com/antongaenko/keybro/blob/main/keybro/Keybro.swift). You can run an example app or scroll below for inspiration.

## Why?

If you check how many times you repeat the same actions during development (drag cursor, click, scroll, drag again, click and so on), you may recognize that doing the same with keyboard shortcuts can save you some time and effort. Actually you can just use `UIKeyCommand` if you don't want to use this micro lib and get the same results. It's up to you.

## Examples

The main purpose of this project is to give your ideas and basic tools.

A) Show specific screens and close them without single touch ([link to source code](https://github.com/antongaenko/keybro/blob/main/keybro/Examples/ScenariosExampleViewController.swift#L19))

<img src=https://raw.githubusercontent.com/antongaenko/d/main/keybro/scenario.gif width=200>

B) Loop through controls on a screen ([link to source code](https://github.com/antongaenko/keybro/blob/main/keybro/Examples/LoopThroughCommandsProtocol.swift#L16))

<img src=https://raw.githubusercontent.com/antongaenko/d/main/keybro/controls.gif width=200>

C) Use space for scrolling content ([link to source code](https://github.com/antongaenko/keybro/blob/main/keybro/Examples/ScrollCommandsProtocol.swift#L20))

<img src=https://raw.githubusercontent.com/antongaenko/d/main/keybro/space.gif width=200>

D) Use numeric pad to enter pass code ([link to source code](https://github.com/antongaenko/keybro/blob/main/keybro/Examples/PinExampleViewController.swift#L22))

<img src=https://raw.githubusercontent.com/antongaenko/d/main/keybro/digits.gif width=200>

E) Use arrows `← →` for app navigation ([link to source code](https://github.com/antongaenko/keybro/blob/main/keybro/AppDelegate.swift#L68))

<img src=https://raw.githubusercontent.com/antongaenko/d/main/keybro/arrows.gif width=200>

F) Switch tabs in tab controller ([link to source code](https://github.com/antongaenko/keybro/blob/main/keybro/AppDelegate.swift#L80))

<img src=https://raw.githubusercontent.com/antongaenko/d/main/keybro/tabs.gif width=200>

G) Or make some useless and fun things like zooming 🔫 ([link to source code](https://github.com/antongaenko/keybro/blob/main/keybro/Examples/LoopThroughExampleViewController.swift#L75))

<img src=https://raw.githubusercontent.com/antongaenko/d/main/keybro/zoom.gif width=200>


## Installation

### Option A. Manual installation
Just download and add `Keybro.swift` as a source file to your project (its 120 lines of code).

```curl -O https://raw.githubusercontent.com/antongaenko/keybro/main/keybro/Keybro.swift```

### Option B. Use SPM

Package name is Keybro and full package link is `https://github.com/antongaenko/keybro`.

Add `import Keybro`. That's it.

### Other options

I'm also planning to add support for Cocoapods and Carthage later.

## How to use?

Call methods on `UIViewController` instance: `add(command: Command)` or `add(commands: [Command])`. 

If you want to add keyboard shortcuts only in debug builds just use `addDebug(command: Command)` or `addDebug(commands: [Command])` methods. 

You can call `removeAllCommands()` at any time to remove commands attached to the current view controller. There is no need to call it in simple cases. 

For example for predefined keys ([space, enter, backspace, digits, tab](https://github.com/antongaenko/keybro/blob/main/keybro/Keybro.swift#L13)) you can write:

```swift
controller.add(commands: [.space(dismiss), .enter(dismiss), .backspace(dismiss)])
```
> Check this full example [ScenariosExampleViewController](ScenariosExampleViewController.swift)

For custom keys with arrows you can write:

```swift
navigationController.add(commands: [
    .custom(input: UIKeyCommand.inputRightArrow, modifiers: [], action: { [weak navigationController] in
        navigationController?.pushViewController(LoopThroughExampleViewController(), animated: true)
    }),
    .custom(input: UIKeyCommand.inputLeftArrow, modifiers: [], action: { [weak navigationController] in
        navigationController?.popViewController(animated: true)
    })
])
```
> Check full example [AppDelegate](https://github.com/antongaenko/keybro/blob/main/keybro/AppDelegate.swift#L68)

**Don't forget using `weak` reference in action blocks of commands.**

## Contributing

If you find any bug please open an issue and provide details.

## Author

👋🏻 [Anton Gaenko](https://www.linkedin.com/in/antongaenko/). You can contact me `hi (at) antongaenko.dev` for questions or if you want to code together.
May be you want to support me but don’t see any payment link )) 

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Afterwords

If you find this project useful for you and your team, spread the word and star this project. Good luck and happy coding! 💁‍♂️
