// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DirectoryWatcher",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        .executable(name: "directory-watcher", targets: ["DirectoryWatcher"]),
        .library(name: "DirectoryWatcherCore", targets: ["DirectoryWatcherCore"])
    ],
    dependencies: [
        .package(url: "https://github.com/ChimeHQ/GlobPattern.git", from: "0.1.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
        .package(url: "https://github.com/apple/swift-async-algorithms", from: "0.1.0"),
        .package(url: "https://github.com/eonist/FileWatcher.git", from: "0.2.3"),
        .package(url: "https://github.com/johnsundell/files.git", from: "4.0.0"),
        .package(url: "https://github.com/johnsundell/shellout.git", from: "2.3.0"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "5.0.4")
    ],
    targets: [
        .executableTarget(
            name: "DirectoryWatcher",
            dependencies: [
                "DirectoryWatcherCore",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        ),
        .target(
            name: "DirectoryWatcherCore",
            dependencies: [
                .product(name: "AsyncAlgorithms", package: "swift-async-algorithms"),
                .product(name: "FileWatcher", package: "FileWatcher"),
                .product(name: "Files", package: "files"),
                .product(name: "GlobPattern", package: "GlobPattern"),
                .product(name: "ShellOut", package: "shellout"),
                .product(name: "Yams", package: "yams")
            ]
        ),
        .testTarget(
            name: "DirectoryWatcherCoreTests",
            dependencies: ["DirectoryWatcherCore"]
        )
    ]
)
