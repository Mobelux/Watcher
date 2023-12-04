//
//  EventStreamGenerator.swift
//  DirectoryWatcher
//
//  Created by Mathew Gacy on 6/23/23.
//

import FileWatcher
import Foundation

/// A type that can generate a stream of Directory Events.
public struct EventStreamGenerator {
    /// Returns a stream of ``DirectoryEvent``s for the specified paths.
    ///
    /// - Parameter paths: The paths to watch.
    /// - Returns: A stream of events.
    public static func changes(
        on paths: [String]
    ) -> AsyncThrowingStream<DirectoryEvent, Error> {
        .init { continuation in
            let watcher = FileWatcher(paths)
            watcher.callback = { watcherEvent in
                guard let event = DirectoryEvent(watcherEvent) else {
                    return
                }
                continuation.yield(event)
            }

            continuation.onTermination = { @Sendable _ in
                watcher.stop()
            }

            watcher.start()
        }
    }
}
