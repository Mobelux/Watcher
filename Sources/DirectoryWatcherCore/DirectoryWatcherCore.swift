//
//  DirectoryWatcherCore.swift
//  DirectoryWatcher
//
//  Created by Mathew Gacy on 6/22/23.
//

import AsyncAlgorithms
import Foundation

public struct DirectoryWatcherCore {
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
            throw DirectoryWatcherError.custom("Unable to read expected config at `\(configURL)`")
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

extension DirectoryWatcherCore {
    static func makeTask(
        watching paths: [String],
        throttleInterval: Int,
        operation: @escaping @Sendable (DirectoryEvent) async -> Void
    ) -> Task<Void, Error> {
        .detached {
            do {
                for try await event in EventStreamGenerator
                    .changes(on: paths)
                    .throttle(for: .seconds(throttleInterval)) {
                    await operation(event)
                }
            } catch {
                log("Error: \(error)")
                return
            }
        }
    }
}
