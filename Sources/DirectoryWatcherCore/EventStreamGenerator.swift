//
//  EventStreamGenerator.swift
//  DirectoryWatcher
//
//  Created by Mathew Gacy on 6/23/23.
//

import FileWatcher
import Foundation

public struct EventStreamGenerator {
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
