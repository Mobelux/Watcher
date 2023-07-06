//
//  DirectoryWatcher.swift
//  DirectoryWatcher
//
//  Created by Mathew Gacy on 6/22/23.
//

import ArgumentParser
import Foundation
import DirectoryWatcherCore

@main
struct DirectoryWatcher: AsyncParsableCommand {
    @Option(name: .shortAndLong, help: "The path to a configuration file.")
    var config: String? = nil

    @Option(name: .shortAndLong, help: "The minimum interval, in seconds, between command execution in response to file changes.")
    var throttle: Int?

    mutating func run() async throws {
        let watchTask = try DirectoryWatcherCore.watch(
            configurationPath: config,
            throttleInterval: throttle)
        try await watchTask.value
    }
}
