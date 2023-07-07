//
//  EventStreamGenerator.swift
//  DirectoryWatcher
//
//  Created by Mathew Gacy on 6/23/23.
//

#if canImport(FileWatcher)
import FileWatcher
#endif
import Foundation

public struct EventStreamGenerator {
    public static func changes(
        on paths: [String]
    ) -> AsyncThrowingStream<DirectoryEvent, Error> {
        .init { continuation in
            #if canImport(FileWatcher)
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
            #else
            continuation.finish(
                throwing: DirectoryWatcherError.custom("DirectoryWatcher is not supported on this platform"))
            #endif
        }
    }
}
