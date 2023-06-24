//
//  DirectoryWatcherCore.swift
//  DirectoryWatcher
//
//  Created by Mathew Gacy on 6/22/23.
//

import AsyncAlgorithms
import Files
import FileWatcher
import Foundation

public struct DirectoryWatcherCore {
    public static func watch(
        from folder: Folder = .current,
        configurationPath: String? = nil
    ) throws -> Task<Void, Error> {

        // Load configuration
        let configURL = configurationPath != nil ?
            URL(fileURLWithPath: configurationPath!) :
            folder.url.appendingPathComponent(Constants.defaultConfigurationPath)

        guard let configs: [CommandConfiguration] = try YAMLReader.live.read(at: configURL) else {
            throw DirectoryWatcherError.custom("Unable to read config")
        }

        // Make commands
        let commandProvider = WatchCommandProvider.live(watching: folder.path)
        let commands: [@Sendable (DirectoryEvent) -> Void] = try configs.map(commandProvider.watchCommand(_:))

        log("Watching `\(folder.path)`...")
        return makeTask(
            watching: [folder.path],
            debouncedBy: Constants.debounceDelay,
            operation: { event in
                commands.forEach { $0(event) }
            })
    }
}

extension DirectoryWatcherCore {
    static func makeTask(
        watching paths: [String],
        debouncedBy debounceDelay: Int,
        operation: @escaping @Sendable (DirectoryEvent) async -> Void
    ) -> Task<Void, Error> {
        .detached {
            do {
                for try await event in EventStreamGenerator
                    .changes(on: paths)
                    .debounce(for: .seconds(debounceDelay)) {
                    await operation(event)
                }
            } catch {
                log("Error: \(error)")
                return
            }
        }
    }
}
