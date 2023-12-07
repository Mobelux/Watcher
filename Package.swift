// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Watcher",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        .executable(name: "watcher", targets: ["watcher"]),
        .library(name: "WatcherCore", targets: ["WatcherCore"])
    ],
    dependencies: [
        .package(url: "https://github.com/ChimeHQ/GlobPattern.git", from: "0.1.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
        .package(url: "https://github.com/apple/swift-async-algorithms", from: "0.1.0"),
        .package(url: "https://github.com/eonist/FileWatcher.git", from: "0.2.3"),
        .package(url: "https://github.com/johnsundell/shellout.git", from: "2.3.0"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "5.0.4"),
        .package(url: "https://github.com/mobelux/swift-version-file-plugin", from: "0.2.0")
    ],
    targets: [
        .executableTarget(
            name: "watcher",
            dependencies: [
                "WatcherCore",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        ),
        .target(
            name: "WatcherCore",
            dependencies: [
                .product(name: "AsyncAlgorithms", package: "swift-async-algorithms"),
                .product(name: "FileWatcher", package: "FileWatcher"),
                .product(name: "GlobPattern", package: "GlobPattern"),
                .product(name: "ShellOut", package: "shellout"),
                .product(name: "Yams", package: "yams")
            ]
        ),
        .testTarget(
            name: "WatcherCoreTests",
            dependencies: ["WatcherCore"]
        )
    ]
)
