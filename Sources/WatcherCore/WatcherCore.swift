//
//  WatcherCore.swift
//  Watcher
//
//  Created by Mathew Gacy on 6/22/23.
//

import AsyncAlgorithms
import Foundation

/// The entry point for the `Watcher` command-line tool.
public struct WatcherCore {
    /// Watch the given directory for changes and execute commands in response.
    ///
    /// - Parameters:
    ///   - path: The path of the directory to watch.
    ///   - configurationPath: The path of the tool's configuration file.
    ///   - throttleInterval: The minimum interval between command executions.
    /// - Returns: A reference to the task.
    public static func watch(
        path: String? = nil,
        configurationPath: String? = nil,
        throttleInterval: Int? = nil
    ) throws -> Task<Void, Error> {
        let watchedPath = path ?? FileManager.default.currentDirectoryPath

        // Load configuration
        let configURL = configurationPath.flatMap { URL(fileURLWithPath: $0) }
            ?? URL(fileURLWithPath: watchedPath).appendingPathComponent(Constants.defaultConfigurationPath)

        guard let configs: [CommandConfiguration] = try YAMLReader.live.read(at: configURL) else {
            throw WatcherError.custom("Unable to read expected config at `\(configURL)`")
        }

        // Make commands
        let commandProvider = WatchCommandProvider.live(watching: watchedPath)
        let commands: [@Sendable (DirectoryEvent) -> Void] = try configs.map(commandProvider.watchCommand(_:))

        log("Watching `\(watchedPath)`...")
        return makeTask(
            watching: [watchedPath],
            throttleInterval: throttleInterval ?? Constants.throttleInterval,
            operation: { event in
                commands.forEach { $0(event) }
            })
    }
}

extension WatcherCore {
    /// Runs the given operation asynchronously.
    ///
    /// - Parameters:
    ///   - paths: The paths to watch.
    ///   - throttleInterval: The minumum interval between command executions.
    ///   - operation: The operation to perform.
    /// - Returns: A reference to the task.
    static func makeTask(
        watching paths: [String],
        throttleInterval: Int,
        operation: @escaping @Sendable (DirectoryEvent) async -> Void
    ) -> Task<Void, Error> {
        .detached {
            do {
                for try await event in EventStreamGenerator
                    .changes(on: paths)
                    ._throttle(for: .seconds(throttleInterval)) {
                    await operation(event)
                }
            } catch {
                log("Error: \(error)")
                return
            }
        }
    }
}
