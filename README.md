![build&test](https://github.com/antongaenko/keybro/workflows/bro%20workflow/badge.svg?branch=main)

# Keybro

No more than easy keyboard shortcuts for your app in [120 lines of code](https://github.com/antongaenko/keybro/blob/main/keybro/Keybro.swift). Checkout and run an example app in a simulator to play with it or see demos below.

## Why?

If you check how many times you repeat the same actions during development (drag cursor, click, scroll, drag again, click and so on), you may recognize that doing the same with keyboard shortcuts can save you some time and effort. 

## Examples

I recommend you to checkout and play with keyboard shortcuts yourself in the demo app for inspiration. The main purpose of this project is to give your ideas and basic tools. But I prepared a few screencasts below.

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

G) Or make some useless and fun things like zooming )) ([link to source code](https://github.com/antongaenko/keybro/blob/main/keybro/Examples/LoopThroughExampleViewController.swift#L75))

<img src=https://raw.githubusercontent.com/antongaenko/d/main/keybro/zoom.gif width=200>


## Installation

Currently the only way is to download and add `Keybro.swift` (its 120 lines of code) to your project directly:

```curl -O https://raw.githubusercontent.com/antongaenko/keybro/main/keybro/Keybro.swift```

## How to use?

You can simply call methods on `UIViewController`: `add(command: Command)` or `add(commands: [Command])`. 

If you want to add keyboard shortcuts only in debug builds just use `addDebug(command: Command)` or `addDebug(commands: [Command])` methods. 

When you leave the screen you can call `removeAllCommands()` inside `viewWillDisappear` to remove commands attached to the current view controller. But take in mind that commands will be removed on `UIViewController.deinit` automatically if you keep weak references on the controller in the command action block, so in simple cases there is no need to call it.

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

[Anton Gaenko](https://www.linkedin.com/in/antongaenko/)
You can contact me `hi (at) antongaenko.dev` for questions or if you want to code together.
May be you want to support me but don’t see any payment link for donate ))

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Afterwords

If you find this project useful for you and your team, spread the word and star this project. Good luck and happy coding! 💁‍♂️

<p>
<a class="github-button" href="https://github.com/ntkme/github-buttons" data-icon="octicon-star" data-size="large" aria-label="Star ntkme/github-buttons on GitHub">Star</a>

<a class="github-button" href="https://github.com/ntkme/github-buttons/subscription" data-icon="octicon-eye" data-size="large" aria-label="Watch ntkme/github-buttons on GitHub">Watch</a>

<a class="github-button" href="https://github.com/ntkme/github-buttons/archive/master.zip" data-icon="octicon-download" data-size="large" aria-label="Download ntkme/github-buttons on GitHub">Download</a>
</p>
