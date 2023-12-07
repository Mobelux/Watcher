//
//  Mock.swift
//  Watcher
//
//  Created by Mathew Gacy on 6/23/23.
//

@testable import WatcherCore
import Foundation

enum Mock {}

// MARK: - Configuration
extension Mock {
    static let swiftPattern = "/Sources/**/*.swift"
    static let scssPattern = "/src/scss/**/*.scss"
    static let excludePattern = "/**/ignore.scss"

    static var configYAML = """
    - pattern: "\(swiftPattern)"
      command: swift run
      name: Generate Site
    - pattern: "\(scssPattern)"
      command: echo "compile Sass"
      exclude: "\(excludePattern)"

    """

    static var commandConfigurations: [CommandConfiguration] {
        [
            CommandConfiguration(pattern: swiftPattern, command: "swift run", name: "Generate Site"),
            CommandConfiguration(pattern: scssPattern, command: #"echo "compile Sass""#, exclude: excludePattern)
        ]
    }
}

// MARK: - Paths
extension Mock {
    static let watchedPath = "/Users/jane/Developer/Publish"

    static var matchingCSSPath: String {
        "\(watchedPath)/src/scss/components/_nav.scss"
    }

    static var matchingSwiftPath: String {
        "\(watchedPath)/Sources/Extensions/String+Utils.swift"
    }

    static var notMatchingPath: String {
        "\(watchedPath)/README.md"
    }

    static var excludedPath: String {
        "\(watchedPath)/src/scss/foo/ignore.scss"
    }
}

// MARK: - Events
extension Mock {
    static var matchingCSSEvent: DirectoryEvent {
        .init(path: matchingCSSPath, description: "")
    }

    static var matchingSwiftEvent: DirectoryEvent {
        .init(path: matchingSwiftPath, description: "")
    }

    static var notMatchingEvent: DirectoryEvent {
        .init(path: notMatchingPath, description: "")
    }

    static var excludedEvent: DirectoryEvent {
        .init(path: excludedPath, description: "")
    }
}
