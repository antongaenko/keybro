![build&test](https://github.com/antongaenko/keybro/workflows/bro%20workflow/badge.svg?branch=main)

# Keybro

No more than easy shortcuts for your app in [120 lines of code](https://github.com/antongaenko/keybro/blob/main/keybro/Keybro.swift). Checkout and run example app in simulator to play with it or see demos below.

## Why?

If you check how many times you repeat the same actions during development (drag cursor, click, scroll, drag again, click and so on), you may recognize that doing the same with shortcuts can save you some time and efforts. 

## Examples

I recommend you to checkout and play with shortcuts in demo app for inspiration. The main purpose of this project is to give your ideas and basic tool. But I prepared few screencasts below.

A) Show specific screens and close them without single touch ([link to source code](https://github.com/antongaenko/keybro/blob/main/keybro/Examples/ScenariosExampleViewController.swift#L19))

<img src=https://raw.githubusercontent.com/antongaenko/d/main/keybro/scenario.gif width=200>

B) Loop through controls on a screen ([link to source code](https://github.com/antongaenko/keybro/blob/main/keybro/Examples/LoopThroughCommandsProtocol.swift#L16))

<img src=https://raw.githubusercontent.com/antongaenko/d/main/keybro/controls.gif width=200>

C) Use numeric pad to enter pass code ([link to source code](https://github.com/antongaenko/keybro/blob/main/keybro/Examples/PinExampleViewController.swift#L22))

<img src=https://raw.githubusercontent.com/antongaenko/d/main/keybro/digits.gif width=200>

D) Use arrows `← →` for app navigation ([link to source code](https://github.com/antongaenko/keybro/blob/main/keybro/AppDelegate.swift#L68))

<img src=https://raw.githubusercontent.com/antongaenko/d/main/keybro/arrows.gif width=200>

E) Switch tabs in tab controller ([link to source code](https://github.com/antongaenko/keybro/blob/main/keybro/AppDelegate.swift#L80))

<img src=https://raw.githubusercontent.com/antongaenko/d/main/keybro/tabs.gif width=200>

F) Or make some useless and fun things like zooming 😃 ([link to source code](https://github.com/antongaenko/keybro/blob/main/keybro/Examples/LoopThroughExampleViewController.swift#L75))

<img src=https://raw.githubusercontent.com/antongaenko/d/main/keybro/zoom.gif width=200>


## Installation

...


## How to use?


Call `add(command: Command)` or `add(commands: [Command])`. You probably want to add most of shortcuts only in debug builds. In such cases use `addDebug(commands: [Command])`. Call `removeAllCommands` when you leave a screen.

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

## Contributing

If you found issues please open an issue and provide details.

## Author

Anton Gaenko
You can contact `hi @ antongaenko.dev` for questions or if you want to code together especially in open source projects.
May be you want to support me but don’t see any payment link for donate )))

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Afterwords

If you find this project useful for you and your team, spread the word and star this project. Good luck and happy coding! 💁‍♂️
