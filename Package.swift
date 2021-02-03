// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Keybro",
    platforms: [
        .iOS(.v9),
    ],
    products: [
        .library(name: "Keybro", targets: ["Keybro"]),
    ],
    targets: [
        .target(
            name: "Keybro",
            dependencies: [],
            path: "keybro",
            sources: ["Keybro.swift"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
