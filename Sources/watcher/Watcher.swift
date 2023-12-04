//
//  Watcher.swift
//  Watcher
//
//  Created by Mathew Gacy on 6/22/23.
//

import ArgumentParser
import Foundation
import WatcherCore

/// The entry point for the `Watcher` command-line tool.
@main
struct Watcher: AsyncParsableCommand {
    /// The path to a configuration file.
    @Option(name: .shortAndLong, help: "The path to a configuration file.")
    var config: String? = nil

    /// The minimum interval, in seconds, between command execution in response to file changes.
    @Option(name: .shortAndLong, help: "The minimum interval, in seconds, between command execution in response to file changes.")
    var throttle: Int?

    /// Runs the command.
    mutating func run() async throws {
        let watchTask = try WatcherCore.watch(
            configurationPath: config,
            throttleInterval: throttle)
        try await watchTask.value
    }
}
